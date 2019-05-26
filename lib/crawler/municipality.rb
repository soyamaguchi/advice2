module Crawler::Municipality

  # crawlerの実行
  def self.execute
    agent = Mechanize.new
    # 大阪府大阪市のサイト
    url = "http://www.city.osaka.lg.jp/"
    page = agent.get(url)

    # 「くらし」ページへ遷移
    item_page = screen_transition(page, "//div[@class='head_sitenavi sp_none']/ul[@class='clear']/li[@class='type01']/a/@href")

    # 「くらし」ページのライフイベントリスト
    item_urls = item_page.search("//div[@class='icon_list01 clear']/a/@href")
    item_urls.length.times do |i|
      i += 1

      # ライフイベント「妊娠・出産」「子育て」「教育」「結婚・離婚」「引越し・住まい」「就職・退職」「高齢者・介護」「ご不幸」へ遷移
      category_page = screen_transition(item_page, "//div[@class='free_life_lower match_height01 clm8_4 noborder']/ul[@class='clear']/li[#{i}{]/div[@class='icon_list01 clear']/a/@href")

      # ライフイベント「妊娠・出産」「子育て」「教育」「結婚・離婚」「引越し・住まい」「就職・退職」「高齢者・介護」「ご不幸」ページの区分リスト
      category_urls = category_page.search("//div[@class='h2_box clear']/h2/a/@href")
      category_urls.length.times do |n|
        n += 1

        scraping(i, n)



        # if i == 1
        #   # ライフイベント「妊娠・出産」→「届出・手続き」→「その他」
        #   category_detail_page = screen_transition(category_page, "//div[@class='category_wrap01'][#{i}]/div[@class='category_lower01']/div[@class='category_list01']/ul[@class='icon04']/li[3]/a/@href")
        #   sleep(1)
        #   # ライフイベント「妊娠・出産」→「届出・手続き」→「その他」→「助産制度」
        #   detailed_info_page = screen_transition(category_detail_page, "//div[@class='cat_topics_lower cat_topics_icon']/ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none'][3]/a/@href")
        #   sleep(1)
        #
        #   next
        # elsif i == 2
        #   # ライフイベント「妊娠・出産」→「健診・予防接種」→「お母さんの健康診査」
        #   category_detail_page = screen_transition(category_page, "//div[@class='category_wrap01'][#{i}]/div[@class='category_lower01']/div[@class='category_list01']/ul[@class='icon04']/li[1]/a/@href")
        #   # ライフイベント「妊娠・出産」→「健診・予防接種」→「お母さんの健康診査」→「妊婦の歯科健診」
        #   detailed_info_page = screen_transition(category_detail_page, "//div[@class='cat_topics_lower cat_topics_icon']/ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none'][1]/a/@href")
        #   sleep(1)
        #
        #   next
        # end
      end
    end



    sleep(10)

  end

  private

  # スクレイピング
  def self.scraping(i, n)

    category_xpath = "/div[@class='category_wrap01'][#{n}]/div[@class='h2_box clear']/h2"
    category_detail_xpath = "/div[@class='category_wrap01'][#{n}]/div[@class='category_lower01']/div[@class='category_list01']/ul[@class='icon04']/li"
    detailed_xpath = "/ul[@class='icon04_cat bunrui']/li[@class='cat_topics_icon_none']"
    a_href = "/a@href"

    if i == 1     # 「妊娠・出産」
      pregnancy_childbirth_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 2  # 「子育て」
      child_raising_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 3  # 「教育」
      education_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 4  # 「結婚・離婚」
      marriage_divorce_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 5  # 「引越し・住まい」
      moving_house_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 6  # 「就職・退職」
      working_resign_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 7  # 「高齢者・介護」
      elderly_care_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    elsif i == 8

    end

  end






  # 「行政オンラインサービス」ページのスクレイピング
  # 「情報収集する」→「広報誌や本を読む」
  # 「情報収集する」→「広報誌や本を読む」→「デジタルブック」

  # 「くらし」→「各種メニュー」→「台風21号関連」→「被災された方への支援・相談窓口」
  # 「くらし」→「各種メニュー」→「台風21号関連」→「被災された方への支援・相談窓口」→「台風21号により被災された方に対する市税の減免などについて」「災害見舞金について」「台風21号による住家の被害に係る被災証明書の申請について」「災害時の発達障がいのある方への支援について」「被災した住まいに関する相談について」

  # 「くらし」→「各種メニュー」→「大阪府北部を震源とする地震関連」→「被災された方への支援・相談窓口」
  # 「くらし」→「各種メニュー」→「大阪府北部を震源とする地震関連」→「被災された方への支援・相談窓口」→「大阪府北部を震源とする地震にかかる災害弔慰金・災害障害見舞金・災害援護資金について」「大阪府北部を震源とする地震義援金の第三次配分について」「平成30年大阪府北部を震源とする地震義援金の受付終了について」
  # 「くらし」→「各種メニュー」→「大阪府北部を震源とする地震関連」→「地震への備え・注意喚起」
  # 「くらし」→「各種メニュー」→「大阪府北部を震源とする地震関連」→「地震への備え・注意喚起」→「ブロック塀等の撤去を促進する補助制度について」

  # 「くらし」→「各種メニュー」→「安全・安心」→「救急・消防」
  # 「くらし」→「各種メニュー」→「安全・安心」→「救急・消防」→「トピックス(お知らせ)」→「講習会」→「救急に関する講習会のご案内(個人向け)」「救急に関する講習会(団体向け)」
  # 「くらし」→「各種メニュー」→「安全・安心」→「救急・消防」→「救急医療」→「突然の病気やケガで困ったら」
  # 「くらし」→「各種メニュー」→「安全・安心」→「防災」→「トピックス(お知らせ)」→「被災者生活再建支援事業について」
  # 「くらし」→「各種メニュー」→「安全・安心」→「防災」→「災害に備える」→「住宅の耐震対策」→「民間戸建住宅等の耐震診断・改修等補助制度」「民間建築物の耐震化の促進」「民間住宅の耐震化の促進」「耐震診断義務化建築物の耐震化の促進」
  # 「くらし」→「各種メニュー」→「安全・安心」→「防災」→「災害に備える」→「その他」→「〜大阪市内における建築物の施設・設計者のみなさまへ〜」→「雨水貯留タンク普及促進助成制度」
  # 「くらし」→「各種メニュー」→「安全・安心」→「防災」→「災害が起きたら」→「災害弔慰金・災害障害見舞金(災害援護資金の貸付)」

  # 「くらし」→「各種メニュー」→「戸籍・住民票・印鑑登録」→「戸籍に関すること」→「戸籍証明の交付請求に関すること」→「戸籍届出受理証明書の交付請求」
  # 「くらし」→「各種メニュー」→「戸籍・住民票・印鑑登録」→「住民票の交付請求に関すること」→「東北地方太平洋沖地震にかかる住民票等各種証明書等手数料を免除します」
  # 「くらし」→「各種メニュー」→「戸籍・住民票・印鑑登録」→「相談・問合せ」→「相談をしたい《市民局》」→「消費生活に関する相談(電話・面談・電子メール)」

  # 「くらし」→「各種メニュー」→「税」→「市税についてのお知らせ」→「市税の減免」
  # 「くらし」→「各種メニュー」→「税」→「市税について」→「固定資産税」→「土地」→「保育事業にかかる固定資産税等の軽減措置等について」
  # 「くらし」→「各種メニュー」→「税」→「市税について」→「固定資産税」→「家屋」→「住宅のバリアフリー改修に伴う固定資産税の減額措置について」「住宅の省エネ改修に伴う固定資産税の減額措置について」「認定長期優良住宅にかかる固定資産税の減額措置について」「住宅耐震改修に伴う固定資産税の減額措置について」「要安全確認計画記載建築物等の耐震改修に伴う固定資産税の減額措置について」
  # 「くらし」→「各種メニュー」→「税」→「市税について」→「軽自動車税」→「軽自動車税の減額・免除制度について」
  # 「くらし」→「各種メニュー」→「税」→「市税の納付」→「減免・納税の猶予・救済制度」

  # 「くらし」→「各種メニュー」→「国民健康保険」→「給付について」→「療養の給付」「高額療養費」「一部負担金の減免または徴収猶予」「療養費・移送費・海外療養費の支給」「出産育児一時金」「葬祭費の支給」「国民健康保険の給付」「入院するとき(入院時食事療養費・入院時生活療養費)」
  # 「くらし」→「各種メニュー」→「国民健康保険」→「保険料について」→「保険料の軽減・減免」
  # 「くらし」→「各種メニュー」→「国民健康保険」→「特定健康診査・特定保険指導」→「国民健康保険の保険事業」「特定健診」
  # 「くらし」→「各種メニュー」→「国民健康保険」→「後期高齢者医療制度」→「大阪市後期高齢者医療保険料の延滞金の減免に関する要綱」

  # 「くらし」→「各種メニュー」→「国民年金」→「受給について」→「基礎年金」→「国民年金の給付の種類」「老齢基礎年金」「障がい基礎年金」「遺族基礎年金」
  # 「くらし」→「各種メニュー」→「国民年金」→「受給について」→「第1号被保険者の独自給付」→「死亡一時金」「寡婦年金」「短期在留外国人の脱退一時金」「付加年金」
  # 「くらし」→「各種メニュー」→「国民年金」→「受給について」→「特別障がい給付金、老齢福祉年金、未支給年金、年金生活者支援給付金」→「年金生活者支援給付金」「特別障がい給付金」「未支給年金」
  # 「くらし」→「各種メニュー」→「国民年金」→「保険料について」→「保険料の免除、猶予および特例」→「国民年金保険料の産前産後期間免除制度」「保険料の免除制度」「給付猶予制度」「学生納付特例制度」
  # 「くらし」→「各種メニュー」→「国民年金」→「保険料について」→「保険料の免除、猶予および特例」→「国民年金保険料の産前産後期間免除制度」「保険料の免除制度」「給付猶予制度」「学生納付特例制度」
  # 「くらし」→「各種メニュー」→「国民年金」→「その他」→「国民年金基金」

  # 「くらし」→「各種メニュー」→「交通」→「交通安全」→「計画、運動・取組、その他」→「大阪府高齢者運転免許自主返納サポート制度」

  # 「くらし」→「各種メニュー」→「ごみ・環境保全」→「ご家庭で出るごみ」→「お知らせ」→「マイボトルを持ってエコに出かけよう！」「ごみ減量・3Rに関する啓発相談コーナーを開設しています」「粗大ごみ収集のインターネット受け付けを開始します」
  # 「くらし」→「各種メニュー」→「ごみ・環境保全」→「環境保全」→「補助金、助成など」→「航空機騒音対策区域における補助事業について」

  # 「くらし」→「各種メニュー」→「消費生活」→「消費生活の基礎知識」→「消費に関する情報」→「消費者センター」→「消費生活相談専用電話」「クーリング・オフ」
  # 「くらし」→「各種メニュー」→「消費生活」→「消費生活の基礎知識」→「消費に関する情報」→「消費者センター」→「トラブルバイバイ♪」→「賃貸住宅のトラブルにご注意！」
  # 「くらし」→「各種メニュー」→「消費生活」→「消費生活の基礎知識」→「消費に関する情報」→「消費者センター」→「お知らせ」→「消費者ホットライン「188(いやや)」番について」
  # 「くらし」→「各種メニュー」→「消費生活」→「相談窓口」→「各関係機関の相談窓口」→「法律相談・家庭問題相談・税金相談・登記相談・年金相談・民事調停相談」

  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「お知らせ」→「風しんワクチンの接種費用助成のお知らせ」「造血細胞移植により接種済みの定期予防接種の免疫が失われた方へ」「ぜん息・アレルギー疾患をもつお子さまに」「夜間・休日の医療機関受診時における手話通訳派遣以来の受付」「平成31年度 大阪市健康増進活動事業補助金の申請を受け付けます」「平成31年度 公衆衛星活動事業補助金の申請を受け付けます」「無料低額診療事業」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「成人の健康」→「検査・健診」→「令和元年度大阪市がん検診推進事業(子宮頸がん・乳がん検診無料クーポン券)について」「骨粗しょう症検診」「大阪市がん検診等の一覧」「風しん抗体検査実施のお知らせ」「歯周病検診」「大阪市健康診査」「大阪市HIV(エイズ)・梅毒・クラミジア検査【無料・匿名】」「肝炎ウイルス検査」「車いすの方・休日・外国語・女性スタッフなど対応可能！がん検診取扱医療機関のご案内」「障がい者のための健康診査事業」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「成人の健康」→「予防接種」→「高齢者用肺炎球菌ワクチン接種のお知らせ」「学童期の予防接種」「定期予防接種」「子宮頸がん予防ワクチンの接種について」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「公害健康被害補償制度に関すること」→「公害健康被害の補償等に関する法律関係(補償給付)」「公害保険福祉事業について」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「感染症・病気に関すること」→「学校や施設で実施する結核定期健康診断には一部補助金が交付されます」「呼吸器講演会を開催します！」「結核健診日程」「結核医療費の公費負担」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「こころの健康に関すること」→「自立支援医療(精神通院)」「精神障がい者保険福祉手帳による各種の支援サービス」「税制上の優遇措置の概要」「文化施設等の入場優待」「精神障がい者保険福祉手帳による府立施設使用料等の優待」「特定相談(ひきこもり・依存症・思春期等)」「こころの悩み電話相談」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「市の取り組み」→「イベント・講座など」→「ぜん息児童の健康回復セミナー(スポーツ体験)参加者募集！(締切:2019年11月8日)」「親と子の健康回復教室(野外教室)参加者募集！(締切:2019年9月27日)」「子どものぜん息とアレルギー講演会を開催します！」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「市の取り組み」→「健康づくりに関する情報」→「すこやか手帳(健康手帳)の交付」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「金銭的支援」→「難病のある方へ」→「指定難病医療費助成制度(難病方に基づく制度)」「大阪市の難病対策」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「健康・医療」→「相談」→「常設健康相談【保健師による健康相談】」「健康相談」「身体障がい者相談・判定」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「お知らせ」→「障がい者・障がい児事業所、施設等の情報」「児童発達支援を利用されている3~5歳児に係る利用者負担給付事業」「福祉バス借上げ補助」「重度身体障がい者等タクシー料金給付」「重度身体障がい者自動車改造補助」「交通機関乗車料金福祉措置」「盲ろう者通訳・介助者派遣事業」「要約筆記者派遣」「重度障がい者入浴サービス」「有料道路障がい者割引」「障害者の日常生活及び社会生活を総合的に支援するための法律及び児童福祉法の一部が改正され、新たなサービスが創設されます」「地域相談支援(地域移行支援・地域定着支援)」「舞洲障がい者スポーツセンター」「大阪市住宅入居等支援事業」「地域移行支援利用交通費給付事業」「視覚障がい者訪問事業」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「相談」→「心身障がい者リハビリテーションセンター」→「からだの相談クリニック(総合医療相談)」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「給付・助成」→「福祉手当」→「特別障がい者手当等」「特別児童扶養手当」「障がい児福祉手当」「外国人心身障がい者給付金」「心身障がい者扶養共済制度」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「給付・助成」→「医療費助成」→「入院時食事療養費及び入院時生活療養費の助成について」「重度障がい者医療費の助成」「老人医療費助成制度」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「給付・助成」→「介護・扶養手当」→「重症心身障がい者介護手当」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「給付・助成」→「生活用具・住宅改修」→「重度障がい者日常生活用具の給付」「大阪市点字図書給付事業」「重度心身障がい者(児)住宅改修費給付」「大阪市難聴児補聴器の購入に要する経費を支給します」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「生活支援」→「日常生活支援」→「重度障がい者等タクシー料金給付」「障がいのある児童のための支援について」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「生活支援」→「意思疎通支援」→「医療機関などを対象とした手話の出前講座」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「障害者総合支援法とは」→「障害者総合支援法」→「大阪市重症心身障がい児者等医療型短期入所を実施しています」「補装具の購入・借受け・修理にかかる費用の支給」「障がい福祉サービスの利用者負担及び軽減措置」「障がい福祉サービスの種類と内容(平成30年4月1日移行)」「重度障がい者等入院時コミュニケーションサポート事業の概要」「大阪市における移動支援事業の概要」「障がい福祉サービスの利用者負担等に係る寡婦控除等のみなし適用について」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「障がいのある方へ」→「医療」→「自立支援医療(更生医療)」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「生活にお困りの方へ」→「お知らせ」→「生活福祉資金貸付」「緊急援護資金」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「生活にお困りの方へ」→「生活支援」→「中国残留邦人等に対する地域生活支援(中国残留邦人等に対する支援給付)」「生活保護」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「生活にお困りの方へ」→「貸付制度」→「母子父子寡婦福祉資金の貸付」
  # 「くらし」→「各種メニュー」→「健康・医療・福祉」→「認知症の方への支援」→「認知症の相談窓口」→「事業一覧」→「認知症高齢者緊急ショートステイ事業を実施します」

  # 「くらし」→「各種メニュー」→「文化・スポーツ・生涯学習」→「歴史・文化に関する取り組み」→「活動助成など」→「芸術活動(団体・個人)助成事業」「芸術・文化団体サポート事業」

  # 「くらし」→「各種メニュー」→「市民活動・コミュニティ」→「市民活動をしたい方へ」→「市民活動に対する支援」→「民間助成制度の活用について」



  # 「妊娠・出産」ページのスクレイピング
  def self.pregnancy_childbirth_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)

    if n == 1
      # 「届出・手続き」→「その他」
      category_detail_xpath_01 = "#{category_detail_xpath}[3]#{a_href}"
      # 「届出・手続き」→「その他」→「助産制度」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[3]#{a_href})
    elsif n == 2
      # 「健診・予防接種」→「お母さんの健康診査」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「健診・予防接種」→「お母さんの健康診査」→「妊婦の歯科健診」「産婦健康診査」「妊婦健康診査」「妊娠中に気をつけたい感染症について」「風しんワクチンの接種費用助成のお知らせ」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[3]#{a_href} #{detailed_xpath}[4]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[6]#{a_href})

      # 「健診・予防接種」→「赤ちゃんの健康診査」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「健診・予防接種」→「赤ちゃんの健康診査」→「1歳6か月児健康診査」「3歳児健康診査」「幼児歯科健康診査」「3か月児健康診査」「乳児一般健康診査」「新生児聴覚検査」「先天性代謝異常等検査」
      detailed_info_xpath_02 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[3]#{a_href} #{detailed_xpath}[4]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[6]#{a_href} #{detailed_xpath}[7]#{a_href})

      # 「健診・予防接種」→「乳幼児期の予防接種」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      # 「健診・予防接種」→「乳幼児期の予防接種」→「予防接種の基本知識」「造血細胞移植により接種済みの定期予防接種の免疫が失われた方へ」
      detailed_info_xpath_03 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href})

      # 「健診・予防接種」→「産前・産後の訪問指導」
      category_detail_xpath_04 = "#{category_detail_xpath}[4]#{a_href}"
      # 「健診・予防接種」→「産前・産後の訪問指導」→「妊産婦訪問」「新生児等の訪問指導」「エンゼルサポーターの派遣について」
      detailed_info_xpath_04 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[3]#{a_href})
    elsif n == 3
      # 「金銭的支援」→「妊娠・出産に関する金銭的支援」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「金銭的支援」→「妊娠・出産に関する金銭的支援」→「産後ケア事業」「助産施設への入所について」「不妊に悩む方への特定治療支援事業(特定不妊治療費助成)」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[3]#{a_href} #{detailed_xpath}[4]#{a_href} #{detailed_xpath}[5]#{a_href})

      # 「金銭的支援」→「育児に関する金銭的支援」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「金銭的支援」→「育児に関する金銭的支援」→「児童手当」「未熟児養育医療の給付」「新生児聴覚検査」
      detailed_info_xpath_02 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[3]#{a_href})

      # 「金銭的支援」→「ひとり親の方への金銭的支援」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      # 「金銭的支援」→「ひとり親の方への金銭的支援」→「母子父子寡婦福祉資金の貸付」「ひとり親家庭高等職業訓練促進資金貸付事業」
      detailed_info_xpath_03 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href})
    elsif n == 4
      # 「教育・保育サービス」→「教育・保育サービスの利用について」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「教育・保育サービス」→「教育・保育サービスの利用について」→「延長保育」「休日保育」「夜間保育」「平成31年度 保育所・認定こども園・地域型保育事業の開所時間について」「平成30年4月からの利用者負担額(保育料)について」「平成31年度 実費徴収に係る補足給付事業のご案内」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[3]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[10]#{a_href})
    elsif n == 5
      # 「サポート・施設・コミュニティ」→「サポート」
      category_detail_xpath_01 = "#{category_detail_xpath}[2]#{a_href}"
      # 「サポート・施設・コミュニティ」→「サポート」→「母子生活支援施設」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[9]#{a_href})

      # 「サポート・施設・コミュニティ」→「施設」
      category_detail_xpath_02 = "#{category_detail_xpath}[3]#{a_href}"
      # 「サポート・施設・コミュニティ」→「施設」→「保育・幼児教育センター 関係機関」「保育・幼児教育センター 認可外保育施設教育費補助診査」
      detailed_info_xpath_02 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[3]#{a_href})
    elsif n == 6

    elsif n == 7
      # 「その他」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「その他」→「子育ていろいろ便利帳」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[3]#{a_href})
    end

  end

  # 「子育て」ページのスクレイピング
  def self.child_raising_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)

    if n == 1
      # 「健診・予防接種」→「お子さんの健康診査」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「健診・予防接種」→「お子さんの健康診査」→「乳幼児アトピー・ぜん息相談のご案内[要予約]」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[6]#{a_href})

      # 「健診・予防接種」→「幼児期の予防接種」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「健診・予防接種」→「幼児期の予防接種」→「4種混合ワクチン及びポリオワクチン接種のお知らせ」「日本脳炎予防接種のお知らせ」「ヒブワクチン及び小児用肺炎球菌ワクチン接種のお知らせ」「水痘(みずぼうそう)ワクチン接種のお知らせ」「B型肝炎ワクチンの予防接種が定期接種になりました」
      detailed_info_xpath_02 = %W(#{detailed_xpath}[3]#{a_href} #{detailed_xpath}[4]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[6]#{a_href} #{detailed_xpath}[7]#{a_href})
    elsif n == 2
      # 「金銭的支援」→「育児に関する金銭的支援」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「金銭的支援」→「育児に関する金銭的支援」→「結核児童の療育給付」「大阪市若年ひとり親の新たな家庭生活支援事業」「こどもの医療費を助成します」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[4]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[7]#{a_href})

      # 「金銭的支援」→「ひとり親の方への金銭的支援」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「金銭的支援」→「ひとり親の方への金銭的支援」→「児童扶養手当」「ひとり親家庭の医療費助成」「ひとり親家庭高等学校卒業程度認定試験合格支援事業」「ひとり親家庭高等職業訓練促進給付金」「ひとり親家庭専門学校等受験対策給付金」「ひとり親家庭自立支援教育訓練給付金」「ひとり親家庭高等職業訓練促進資金貸付事業」「ひとり親家庭等への支援」
      detailed_info_xpath_02 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[5]#{a_href} #{detailed_xpath}[6]#{a_href} #{detailed_xpath}[7]#{a_href} #{detailed_xpath}[8]#{a_href} #{detailed_xpath}[9]#{a_href} #{detailed_xpath}[10]#{a_href})

      # 「金銭的支援」→「障害、難病のあるお子さんへの金銭的支援」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      # 「金銭的支援」→「障害、難病のあるお子さんへの金銭的支援」→「小児慢性特定疾病医療費の助成」「小児慢性特定疾病児日常生活用具給付事業」「こども難病日常生活用具給付事業」「自立支援医療(育成医療)」「こども難病医療費助成制度について」
      detailed_info_xpath_03 = %W(#{detailed_xpath}[1]#{a_href} #{detailed_xpath}[2]#{a_href} #{detailed_xpath}[3]#{a_href} #{detailed_xpath}[4]#{a_href} #{detailed_xpath}[6]#{a_href})
    elsif n == 3
      # 「教育・保育サービス」→「教育・保育サービスの利用について」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「教育・保育サービス」→「教育・保育サービスの利用について」→「4・5歳児にかかる幼児教育の無償化」「認可外保育施設について」「平成30年度 実費徴収に係る補足給付事業のご案内」
      detailed_info_xpath_01 = %W(#{detailed_xpath}[5]#{a_href} #{detailed_xpath}[10]#{a_href} #{detailed_xpath}[18]#{a_href})

      # 「教育・保育サービス」→「幼稚園での教育・保育サービス」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「教育・保育サービス」→「幼稚園での教育・保育サービス」→「私立幼稚園に就園しているお子さんの保育料に対する補助」

      # 「教育・保育サービス」→「一時的に利用できる保育サービス」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      # 「教育・保育サービス」→「一時的に利用できる保育サービス」→「病児・病後児保育事業」「一時預かり」「大阪市一時預かり事業利用料減免申請について」「ショートステイ」「大阪市子育て短期支援事業(子どものショートステイ事業)の利用について」

      # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」
      category_detail_xpath_04 = "#{category_detail_xpath}[4]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「保育所」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「保育所」→「大阪市内保育施設等の空き情報について」「保育所・認定こども園(保育認定)・地域型保育事業の保育料について」「公立保育所延長保育事業について」「障がいのあるこどもの保育所入所について」
        elsif i == 2
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「認定こども園」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「認定こども園」→「幼稚園・認定こども園(教育標準時間認定)の保育料について」「保育施設・事業の利用について」
        elsif i == 3
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「地域型保育事業」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「地域型保育事業」→「地域型保育への入所」
        elsif i == 4
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「認可外保育施設」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「教育・保育サービス」→「大阪市内の保育所・保育サービス」→「認可外保育施設」→「認可外保育施設について」「認可外保育施設における幼児教育の無償化について」
        end
      end

      # 「教育・保育サービス」→「大阪市内の幼稚園」
      category_detail_xpath_05 = "#{category_detail_xpath}[5]#{a_href}"
      # 「教育・保育サービス」→「大阪市内の幼稚園」→「幼稚園の預かり保育」

      # 「教育・保育サービス」→「保育所での様々なサポート」
      category_detail_xpath_06 = "#{category_detail_xpath}[6]#{a_href}"
      # 「教育・保育サービス」→「保育所での様々なサポート」→「教育・保育施設、地域型保育の保育料の減免」

      # 「教育・保育サービス」→「事業者向け」
      category_detail_xpath_08 = "#{category_detail_xpath}[8]#{a_href}"
      # 「教育・保育サービス」→「事業者向け」→「大阪市新規採用保育士特別給付補助金交付要綱」
    elsif n == 4
      # 「サポート・施設・コミュニティ」→「各種教室・講習会」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「サポート・施設・コミュニティ」→「各種教室・講習会」→「母親教室」

      # 「サポート・施設・コミュニティ」→「サポート」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「サポート・施設・コミュニティ」→「サポート」→「ひとり親家庭等日常生活支援事業」「塾代助成事業」「緊急母子一時保護」「養育費の確保・面会交流について(ひとり親家庭支援)」「里親制度」

      # 「サポート・施設・コミュニティ」→「施設」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      # 「サポート・施設・コミュニティ」→「施設」→「子育て活動支援事業(子ども・子育てプラザ)」「保育士資格取得における認可外保育施設での勤務経験による合格科目免除期間延長について」「児童福祉施設」「赤ちゃんの短期預かり」

      # 「サポート・施設・コミュニティ」→「その他」
      category_detail_xpath_05 = "#{category_detail_xpath}[5]#{a_href}"
      # 「サポート・施設・コミュニティ」→「その他」→「大阪市赤ちゃんの駅」
    elsif n == 5
      # 「相談・問い合わせ」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「相談・問い合わせ」→「小児慢性特定疾病児等療養相談会」「弁護士による「離婚・養育費」に関する無料の専門相談を実施します」「児童虐待ホットラインと児童虐待メール相談」「4・5歳児発達相談」「発達障がいのある方への支援」「虐待から子どもを守るために」「こどものいじめ、児童虐待、体罰等に関するSOS」
    elsif n == 6

    end

  end

  # 「教育」ページのスクレイピング
  def self.education_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)

    if n == 1
      # 「幼稚園」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「幼稚園」→「大阪市内幼稚園・保育所等マップ」「幼児教育の無償化」
    elsif n == 2
      # 「小学校」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「小学校」→「小・中学校の就学援助」
    elsif n == 3
      # 「中学校」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「中学校」→「大阪市立中学校の夜間学級」
    elsif n == 4
      # 「高校」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「高校」→「大阪市奨学費」「主な奨学金等支援制度の概要」
    elsif n == 5

    elsif n == 6

    elsif n == 7
      # 「障がいのあるお子さんへ」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「障がいのあるお子さんへ」→「特別支援教育就学奨励費」
    elsif n == 8

    elsif n == 9

    elsif n == 10
      # 「サポート・施設・コミュニティ」→「施設」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「サポート・施設・コミュニティ」→「施設」→「大阪市立 阿武山学園」
    elsif n == 11

    elsif n == 12

    end

  end

  # 「結婚・離婚」ページのスクレイピング
  def self.marriage_divorce_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)

    if n == 1
      # 「戸籍などの届出」→「結婚する方へ」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「戸籍などの届出」→「結婚する方へ」→「大阪市各区のオリジナル婚姻届を配布しています ぜひご利用ください！」

      # 「戸籍などの届出」→「離婚する方へ」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「戸籍などの届出」→「離婚する方へ」→「ひとり親家庭と寡婦の法律・生活相談」「ひとり親家庭サポーター事業」「愛光会館」
    elsif n == 2
      # 「社会保険や手当、名義変更などに関する手続き」→「社会保険・税に関する手続き」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「社会保険や手当、名義変更などに関する手続き」→「社会保険・税に関する手続き」→「結婚・離婚に伴う市税の手続き」
    elsif n == 3

    elsif n == 4

    end

  end

  # 「引越し・住まい」ページのスクレイピング
  def self.moving_house_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    if n == 1
      # 「引越し」→「戸籍、住民基本台帳などに関する手続き」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「引越し」→「戸籍、住民基本台帳などに関する手続き」→「「全国避難者情報システム」受付窓口を各区役所で設置しています」

      # 「引越し」→「生活インフラに関する手続き」
      category_detail_xpath_04 = "#{category_detail_xpath}[4]#{a_href}"
      # 「引越し」→「生活インフラに関する手続き」→「郵便」

      # 「引越し」→「その他」
      category_detail_xpath_05 = "#{category_detail_xpath}[5]#{a_href}"
      # 「引越し」→「その他」→「公社賃貸住宅への入居」「サービス付き高齢者向け住宅登録制度」
    elsif n == 2
      # 「住まい」→「住まいを買う・建てる」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「住まい」→「住まいを買う・建てる」→「届出・手続き」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを買う・建てる」→「届出・手続き」→「住宅用家屋証明書」「長期優良住宅認定制度」
        elsif i == 2
          # 「住まい」→「住まいを買う・建てる」→「金銭的支援」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを買う・建てる」→「金銭的支援」→「大阪市新婚・子育て世帯向け分譲住宅購入融資利子補給制度の概要」「大阪市エコ住宅普及促進事業住宅購入・整備融資利子補給の概要」「固定資産税・都市計画税の減額制度等」
        elsif i == 3
          # 「住まい」→「住まいを買う・建てる」→「サポート」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを買う・建てる」→「サポート」→「住まいに関する相談(大阪市立住まい情報センター)」「住宅の購入を検討されている方、必見！「中古住宅購入不安解消ナビ」を作成しました。」「子育て世帯等支援型民間すまいりんぐ」
        elsif i == 4
          # 「住まい」→「住まいを買う・建てる」→「その他」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを買う・建てる」→「その他」→「エコ住宅のアイディアの事例」
        end
      end

      # 「住まい」→「住まいを建て替える・補修する」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「住まい」→「住まいを建て替える・補修する」→「金銭的支援」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを建て替える・補修する」→「金銭的支援」→「子育て世帯等向け民間賃貸住宅改修費を補助します」「高齢者住宅改修費給付事業」「大阪市民間老朽住宅建替支援事業(タテカエ・サポーティング21)」「民間マンションの耐震診断・改修補助制度」「ブロッグ塀等の撤去を促進する補助制度について」「密集住宅市街地の整備について」「民間戸建住宅等の耐震診断・改修等補助制度」「密集住宅市街地重点整備事業」
        elsif i == 2
          # 「住まい」→「住まいを建て替える・補修する」→「サポート」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを建て替える・補修する」→「サポート」→「分譲マンション再生検討費助成制度」「分譲マンション長期修繕計画作成費助成制度」「分譲マンションアドバイザー派遣制度」
        elsif i == 3

        end
      end

      # 「住まい」→「住まいを借りる」
      category_detail_xpath_03 = "#{category_detail_xpath}[3]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「住まい」→「住まいを借りる」→「サポート」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを借りる」→「サポート」→「民間すまいりんぐ」「セーフティネット住宅(住宅確保要配慮者円滑入居賃貸住宅)の登録制度」「大阪あんぜん・あんしん賃貸住宅登録制度」
        elsif i == 2
          # 「住まい」→「住まいを借りる」→「市営住宅」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを借りる」→「市営住宅」→「大阪市営住宅(公営住宅・改良住宅)の随時募集」「市営すまいりんぐ(子育て応援型)・市営すまいりんぐ・市営特定賃貸住宅・市営再開発住宅の随時募集」「市営住宅への入居」
        elsif i == 3
          # 「住まい」→「住まいを借りる」→「その他」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「住まい」→「住まいを借りる」→「その他」→「高齢者ケア付住宅」「高齢者・高齢者特別設計住宅」「終身建物賃貸借制度」
        end
      end

      # 「住まい」→「相談する」
      category_detail_xpath_04 = "#{category_detail_xpath}[4]#{a_href}"
      # 「住まい」→「相談する」→「地域魅力創出建築物修景事業 建築物の修景に関する相談(修景相談)」
    end
  end

  # 「就職・退職」ページのスクレイピング
  def self.working_resign_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    if n == 1
      # 「求職者の方向けの職業相談・職業紹介」→「すべての方向け」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「求職者の方向けの職業相談・職業紹介」→「すべての方向け」→「大阪市内で保育士として働く方を支援します」
    elsif n == 2
      # 「相談窓口」→「全般」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「相談窓口」→「全般」→「大阪市地域就労支援センター〜就労相談を実施しています〜」「あなたの就職を応援します！大阪市「しごと情報ひろば」をご利用ください！」
    elsif n == 3

    elsif n == 4
      # 「就業支援の取り組み」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「就業支援の取り組み」→「生活困窮者自立支援事業」
    elsif n == 5

    elsif n == 6

    elsif n == 7
      # 「雇用・労働に関するお知らせ」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「雇用・労働に関するお知らせ」→「「大阪府最低賃金」改定のお知らせ」
    elsif n == 8

    end
  end

  # 「高齢者・介護」ページのスクレイピング
  def self.elderly_care_scraping(n, category_xpath, category_detail_xpath, detailed_xpath, a_href)
    if n == 1
      # 「いきいきとした毎日を送る」→「楽しむ」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「いきいきとした毎日を送る」→「楽しむ」→「老人福祉センター」「高齢者の方を文化施設などへ優待します」「敬老優待乗車証(敬老パス)について」「住民の助け合いによる生活支援活動事業(モデル事業)」

      # 「いきいきとした毎日を送る」→「交流する」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「いきいきとした毎日を送る」→「交流する」→「介護予防教室(なにわ元気塾)」「集う場(認知症カフェ等)をご存知ですか？」
    elsif n == 2
      # 「健康な体づくりのために」→「検査・健診」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「健康な体づくりのために」→「検査・健診」→「お知らせ」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「健康な体づくりのために」→「検査・健診」→「お知らせ」→「後期高齢者医療に加入されている方には、葬祭費が給付されます。」「人間ドック費用の助成について」「後期高齢者医療の健康診査について」「交通事故等により介護保険サービスを使う場合について(第三者行為求償)」
        elsif i == 2

        elsif i == 3
          # 「健康な体づくりのために」→「検査・健診」→「その他」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「健康な体づくりのために」→「検査・健診」→「その他」→「結核児童の療育給付」
        end
      end
    elsif n == 3
      # 「医療を受けるために」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「医療を受けるために」→「後期高齢者医療制度」
    elsif n == 4
      # 「介護保険」→「介護保険制度とは」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「介護保険」→「介護保険制度とは」→「介護保険サービス利用にかかる費用の医療費控除について」「介護保険制度のご案内」「介護保険で利用できる居宅サービス」「高額医療・高額介護合算療養費制度のお知らせ」「介護保険で利用できる施設サービス」「社会福祉法人等による利用者負担額軽減制度」「住宅改修費の支給」「介護保険サービスの種類と利用者負担」「介護保険負担限度額認定申請書」「介護保険高額医療(介護予防)サービス費(相当事業費)支給申請書(受領委任払承認及び支給申請書含む)」

      # 「介護保険」→「利用できるサービス」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「介護保険」→「利用できるサービス」→「定期巡回・随時対応型訪問介護看護サービスのご案内」
    elsif n == 5
      # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      .search("//div[@class='h2_box clear']/h2/a/@href")
      .length.times do |i|
        i += 1

        if i == 1
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「日用品や福祉用具の給付・付与」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「日用品や福祉用具の給付・付与」→「介護用品の給付」「在宅高齢者日常生活用具給付事業」
        elsif i == 2

        elsif i == 3

        elsif i == 4
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「緊急時の安心サポート」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「緊急時の安心サポート」→「ふれあいや安否確認のサービス」「緊急通報システム事業」
        elsif i == 5
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「その他サポート」
          "/div[@class='category_wrap01'][#{i}]/div[@class='h2_box clear']/h2#{a_href}"
          # 「在宅・施設の福祉サービス」→「在宅で生活するための福祉サービス」→「その他サポート」→「生活支援型食事サービス事業」「寝具洗濯乾燥消毒サービス」「家族介護慰労金」「在日外国人高齢者給付金」「障がい者控除対象者に認定書を交付します」
        end
      end
      # 「在宅・施設の福祉サービス」→「施設での福祉サービス」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「在宅・施設の福祉サービス」→「施設での福祉サービス」→「軽費老人ホーム」「生活支援ハウス」「養護老人ホーム」
    elsif n == 6
      # 「金銭・交通・住まいなどの多様なサポート」→「金銭的なサポート」
      category_detail_xpath_01 = "#{category_detail_xpath}[1]#{a_href}"
      # 「金銭・交通・住まいなどの多様なサポート」→「金銭的なサポート」→「高齢者の入浴利用料の割引きについて」

      # 「金銭・交通・住まいなどの多様なサポート」→「住まいに関するサポート」
      category_detail_xpath_02 = "#{category_detail_xpath}[2]#{a_href}"
      # 「金銭・交通・住まいなどの多様なサポート」→「住まいに関するサポート」→「市営福祉目的住宅(障がい者向け)ご案内」
    elsif n == 7
      # 「財産管理等が心配な方に」
      category_detail_xpath_01 = "#{category_xpath}#{a_href}"
      # 「財産管理等が心配な方に」→「成年後見制度利用支援事業」「あんしんさぽーと事業(日常生活自立支援事業)」
    elsif n == 8

    elsif n == 9

    end
  end



  # リンククリックし、画面遷移する
  def self.screen_transition(page, xpath)
    transition_url = page.search(xpath)
    transition_page = page.link_with(href: transition_url.text).click
    sleep(1)
    return transition_page
  end

end