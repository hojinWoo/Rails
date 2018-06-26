# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

############## if you want adjust then command################
############## $ rake db:seed                  ###############

#Post.create(title: "제목 test", content: "sasdfasda")


# dummy for loop
#10.times do
#  Post.create(title: "sds", content: "sasdfasda")
#end



### use gem faker ###
# require 'faker'
#
# 5.times do |i|
#   User.create(
#     name: Faker::Pokemon.name,
#     email: "#{i+1}@#{i+2}",
#     password: 123123,
#     password_confirmation: 123123
#   )
# end
#
# 10.times do
#   Post.create(
#     title: Faker::OnePiece.unique.character,
#     content: Faker::OnePiece.quote,
#     user_id: (1..5).to_a.sample
#   )
# end
#
# 20.times do
#   Comment.create(
#     content: "sample댓글",
#     user_id: (1..5).to_a.sample,
#     post_id: (1..10).to_a.sample
#   )
# end


### seed file로 csv 파일 불러오는 것을 많이 사용 ###
require 'csv'
# root 경로 -> db폴더에 있는 seed.csv파일
# 각 row를 hash로 만들어서 Post로 만들기
CSV.foreach(Rails.root.join('db', 'seed.csv'), {headers: true, encoding: "UTF-8"}) do |row|
  Post.create! row.to_hash
end
