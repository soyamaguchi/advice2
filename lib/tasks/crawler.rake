namespace :crawler do
  desc "各自治体サイト(市役所、区役所)から情報をスクレイピングするTask"
  task init: :environment do
    Crawler::Municipality.execute
  end
end