module Crawler::Municipality

  # crawlerの実行
  def self.execute
    agent = Mechanize.new
    # 大阪府大阪市のサイト
    url = "http://www.city.osaka.lg.jp/"
    page = agent.get(url)

    # 「くらし」ページへ遷移
    item_page = screen_transition(page, page.search("//div[@class='head_sitenavi sp_none']/ul[@class='clear']/li[@class='type01']/a/@href"))

    # 行政オンラインサービスへ遷移
    online_service_url = [screen_transition(item_page, item_page.search("//div[@class='ixt_side_right clear']/a/@href"))]
    # ライフイベントリスト
    life_urls = item_page.search("//div[@class='icon_list01 clear']/a/@href").map {|life_url| screen_transition(item_page, life_url)}
    # 各種メニューリスト
    various_menu_urls = item_page.search("//div[@class='h3_box']/h3/a/@href").map {|various_menu_url| screen_transition(item_page, various_menu_url)}

    scraping(online_service_url + life_urls + various_menu_urls)
  end

  private

  # スクレイピング
  def self.scraping(categories)
    # スクレイピング非対称
    asymmetrical = %W(職員等採用 市政に参加する)
    # コンテンツ
    content = {}

    # 各categoryから項目取得
    categories.each_with_index do |category, i|
      # category毎の各セクション
      section_urls = []
      # 各セクションのサブセクション && セクション詳細
      section_detail_urls = []
      # 項目
      item_urls = []

      # カテゴリの新しいお知らせや重要なお知らせを取得
      item_urls.concat(category.search("//ul[@class='icon04_cat bunrui']/li[@class='news_icon_none']/a/@href").map {|new_item_url| screen_transition(category, new_item_url)})

      # カテゴリの全セクション取得
      section_urls.concat(category.search("//div[@class='h2_box clear']/h2/a/@href").map {|section_url| screen_transition(category, section_url)})

      # 全セクションからサブセクション取得 && セクション詳細取得 && セクションから直接取得可能な項目取得
      section_urls.each do |section_url|
        next if section_url.nil?
        section_detail_urls.concat(section_url.search("//div[@class='h2_box clear']/h2/a/@href").map {|section_detail_url| screen_transition(section_url, section_detail_url)})
        item_urls.concat(section_url.search("//ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none']/a/@href").map {|item_url| screen_transition(section_url, item_url)})
      end

      # サブセクションからセクション詳細➡︎項目取得 && サブセクション➡︎項目取得
      section_detail_urls.each do |sub_section_url|
        # 「市政」カテゴリはスクレイピング非対象
        if asymmetrical.include?(sub_section_url.search("//div[@id='sub_h1_box']/h1").text) || sub_section_url.nil?
          next
        end

        # セクション詳細 || 項目
        tmp_urls = sub_section_url.search("//div[@class='h2_box clear']/h2/a/@href").map {|section_detail_url| screen_transition(sub_section_url, section_detail_url)}
        tmp_urls.each do |tmp_url|
          if tmp_url.uri.to_s.include?("page")
            item_urls << tmp_url
          else
            item_urls.concat(tmp_url.search("//ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none']/a/@href").map {|item_url| screen_transition(tmp_url, item_url)})
          end
        end
      end

      # セクション詳細から項目取得
      section_detail_urls.each do |section_detail_url|
        next if section_detail_url.nil?
        item_urls.concat(section_detail_url.search("//ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none']/a/@href").map {|item_url| screen_transition(section_detail_url, item_url)})
      end

      # カテゴリが消費者センターの場合
      if category.search("//div[@id='sub_h1_box']/h1").text == "消費生活"
        cons_center_item_urls = []
        item_urls.each do |item_url|
          # セクション取得
          tmp_section_urls = item_url.search("//div[@class='h3_box']/h3/a/@href").map {|section_url| screen_transition(item_url, section_url)}
          # セクションから項目取得
          tmp_section_urls.each do |tmp_section_url|
            cons_center_item_urls.concat(tmp_section_url.search("//ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none']/a/@href").map {|item_url| screen_transition(tmp_section_url, item_url)})
          end
          cons_center_item_urls.concat(item_url.search("//ul/li[@class='i_list_box']/div[@class='ixt_side_right clear']/a/@href").map {|url| screen_transition(item_url, url)})
        end
        item_urls.concat(cons_center_item_urls)
      end

      content[i] = item_urls
    end

    get_content(content)
  end

  # 整形してinsert
  def self.get_content(content)
    content.each do |k, v|
      v.each do |c|
        next if c.nil? || c.uri.to_s.exclude?("page")

        begin
          # id
          city_id = 1
          # uri
          url = c.uri.to_s
          # 更新日時
          update_time = Date.strptime(c.search("//div[@class='page_day01']").text, "%Y年%m月%d日")
          # メインタイトル
          main_title = c.search("//div[@id='sub_h1_box']/h1").text
          # サブタイトル
          sub_title = c.search("//div[@id='mol_contents']/div[@class='mol_textblock'][1]/preceding-sibling::div[@class='sub_h2_box']").text
          # テキスト
          text = c.search("//div[@id='mol_contents']/div[@class='mol_textblock'][1]").text
          # テキスト上部のテーブル
          table = c.search("//div[@id='mol_contents']/div[@class='mol_textblock'][1]/preceding-sibling::div[@class='mol_tableblock']").text

          # テキストが空やテキスト上部にテーブルが存在する場合
          if text.empty? || !table.empty?
            text = get_table(c) + "\n\n" + text
          end
          # テキストがナビゲーションリンクの場合
          if text.include?("▼")
            sub_title = c.search("//div[@id='mol_contents']/div[@class='mol_textblock'][2]/preceding-sibling::div[@class='sub_h2_box']").text
            text = c.search("//div[@id='mol_contents']/div[@class='mol_textblock'][2]").text
          end
          # textの不要な改行を削除
          while true
            break if !text.start_with?(/\n/)
            text.sub!(/\n/, "")
          end

          municipality_info = MunicipalityInfo.find_or_initialize_by(city_id: city_id, url: url, category: k, update_time: update_time, main_title: main_title)
          next if municipality_info.persisted?

          municipality_info.attributes = {sub_title: sub_title, content: text}
          municipality_info.save
        rescue => e
          puts e
          puts e.backtrace.join("\n")
        end
      end
    end
  end

  # table情報取得
  def self.get_table(page)
    # キャプション thead
    caption = page.search("//div[@id='mol_contents']/div[@class='mol_tableblock'][1]/div/table/caption").text
    # 本文 tbody
    tr = page.search("//div[@id='mol_contents']/div[@class='mol_tableblock'][1]/div/table/tbody/tr").map {|tr| tr.text}
    # 本文の整形
    tbody = tr.map do |tr|
      page.search("//div[@id='mol_contents']/div[@class='mol_tableblock'][1]/div/table/tbody/tr/th").select {|th| tr.include?(th.text)}.map {|td| td.text + ":" + tr.delete(td.text)}
    end.join("\n")
    # キャプションと本文の合成
    text = caption + "\n" + tbody
  end

  # リンククリックし、画面遷移する
  def self.screen_transition(page, transition_url)
    transition_page = page.link_with(href: transition_url.text).click
    sleep(1)
    transition_page
  rescue => e
    # logger.error e.class
    # logger.error e.message
    # logger.error e.backtrace.join("\n")
    puts e
    puts e.backtrace.join("\n")
  end

end