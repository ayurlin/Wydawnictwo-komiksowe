set :deploy_to, "/shared/apps/wydawnictwo_komiksowe/production"

role :app, %w{deploy@shop-front}
role :web, %w{deploy@shop-front}
role :db,  %w{deploy@shop-front}
