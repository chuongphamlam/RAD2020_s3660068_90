# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Forum.create(name: 'RMIT')
Forum.create(name: 'RAILS')
Forum.create(name: 'GIT')
Forum.create(name: 'Canvas')

User.create(name: "Example",email: "example-user@gmail.com",photo: nil,mobile: "0987880890",city: nil,intro: nil,created_at: "2020-05-21 08:17:33", updated_at: "2020-05-21 08:17:33",password_digest: "$2a$10$bi4y.GjIeTgxqifYNTcXgOvTrAgsveqpKu/jJ/UY4itQJVsZTO7y.",remember_digest: nil)

Post.create( user_id: 1, forum_id: 2, photo: "/uploads/defaults/thumb-default.jpg" ,content: "London (CNN Business)Renault may not survive the shock of the ....", title: "Renault could 'disappear'")
