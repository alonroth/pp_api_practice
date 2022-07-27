task :generate_web_token => :environment do |task, args|
  token = JsonWebToken.encode(user_id: '1')
  puts token
end
