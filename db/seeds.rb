Category.destroy_all
User.destroy_all

categories = JSON '[{"category_id":1314,"display_category_name":"","english_category_name":"Sports","url_category_name":""},{"category_id":13,"display_category_name":"Art","english_category_name":"Art","url_category_name":"art"},{"category_id":21,"display_category_name":"Blogs","english_category_name":"Blogs","url_category_name":"blogs"},{"category_id":22,"display_category_name":"Business","english_category_name":"Business","url_category_name":"business"},{"category_id":5,"display_category_name":"Celebrities","english_category_name":"Celebrities","url_category_name":"celebrities"},{"category_id":588,"display_category_name":"Columnists","english_category_name":"Columnists","url_category_name":"columnists"},{"category_id":6,"display_category_name":"Entertainment","english_category_name":"Entertainment","url_category_name":"entertainment"},{"category_id":17,"display_category_name":"Events","english_category_name":"Events","url_category_name":"events"},{"category_id":25,"display_category_name":"Fun Stuff","english_category_name":"Fun Stuff","url_category_name":"fun-stuff"},{"category_id":1168,"display_category_name":"General","english_category_name":"General","url_category_name":"general"},{"category_id":11,"display_category_name":"Health","english_category_name":"Health","url_category_name":"health"},{"category_id":14,"display_category_name":"Hobbies","english_category_name":"Hobbies","url_category_name":"hobbies"},{"category_id":2,"display_category_name":"Industry","english_category_name":"Industry","url_category_name":"industry"},{"category_id":28,"display_category_name":"Internet","english_category_name":"Internet","url_category_name":"internet"},{"category_id":15,"display_category_name":"IT","english_category_name":"IT","url_category_name":"it"},{"category_id":33,"display_category_name":"Jobs","english_category_name":"Jobs","url_category_name":"jobs"},{"category_id":591,"display_category_name":"Law","english_category_name":"Law","url_category_name":"law"},{"category_id":20,"display_category_name":"Life Style","english_category_name":"Life Style","url_category_name":"life-style"},{"category_id":29,"display_category_name":"Music","english_category_name":"Music","url_category_name":"music"},{"category_id":36,"display_category_name":"Oddly Enough","english_category_name":"Oddly Enough","url_category_name":"oddly-enough"},{"category_id":3,"display_category_name":"Politics","english_category_name":"Politics","url_category_name":"politics"},{"category_id":10,"display_category_name":"Products","english_category_name":"Products","url_category_name":"products"},{"category_id":16,"display_category_name":"Programming","english_category_name":"Programming","url_category_name":"programming"},{"category_id":18,"display_category_name":"Religion And Spirituality","english_category_name":"Religion And Spirituality","url_category_name":"religion-and-spirituality"},{"category_id":8,"display_category_name":"Science","english_category_name":"Science","url_category_name":"science"},{"category_id":34,"display_category_name":"Shopping","english_category_name":"Shopping","url_category_name":"shopping"},{"category_id":4,"display_category_name":"Society","english_category_name":"Society","url_category_name":"society"},{"category_id":27,"display_category_name":"Sports","english_category_name":"Sports","url_category_name":"sports"},{"category_id":30,"display_category_name":"Technology","english_category_name":"Technology","url_category_name":"technology"},{"category_id":31,"display_category_name":"Top Blogs","english_category_name":"Top Blogs","url_category_name":"top-blogs"},{"category_id":26,"display_category_name":"Top News","english_category_name":"Top News","url_category_name":"top-news"},{"category_id":23,"display_category_name":"Travel","english_category_name":"Travel","url_category_name":"travel"},{"category_id":12,"display_category_name":"Universities","english_category_name":"Universities","url_category_name":"universities"},{"category_id":7,"display_category_name":"USA","english_category_name":"USA","url_category_name":"usa"},{"category_id":590,"display_category_name":"Video","english_category_name":"Video","url_category_name":"video"},{"category_id":9,"display_category_name":"Video Games","english_category_name":"Video Games","url_category_name":"video-games"},{"category_id":19,"display_category_name":"World News","english_category_name":"World News","url_category_name":"world-news"}]'

categories.each do |cat|
  c =Category.new
  c.api_id = cat["category_id"]
  c.title = cat["english_category_name"]
  c.save
end

u1 = User.create(
  username: "Rira Choi",
  email: "rira.nunu.choi@gmail.com",
  native_country: "au",
  password: "rirachoi",
  password_confirmation: "rirachoi",
  admin: true


u2 = User.create(
  username: "Jane Austen",
  email: "babogirl87@naver.com",
  native_country: "gb",
  password: "janeausten",
  password_confirmation: "janeausten"
  )

c1 = Category.find_by(english_category_name: 'Top News')
c2 = Category.find_by(english_category_name: 'Art')
c3 = Category.find_by(english_category_name: 'Programming')

c4 = Category.find_by(english_category_name: 'Society')
c5 = Category.find_by(english_category_name: 'Politics')

u1.categories << c1 << c2 << c3
u2.categories << c4 << c5
