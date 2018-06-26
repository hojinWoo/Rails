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

# use gem faker
require 'faker'
10.times do
  Post.create(
    title: Faker::OnePiece.unique.character,
    content: Faker::OnePiece.quote
  )
end
