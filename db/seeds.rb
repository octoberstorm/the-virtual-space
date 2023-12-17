# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

puts "Seeding database..."

User.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all

# JSON data for users
users_data = [
  { name: 'Joe Milton', email: 'user1@example.com', password: 'password1', password_confirmation: 'password1' },
  { name: 'Jake Miller', email: 'user2@example.com', password: 'password2', password_confirmation: 'password2' }
]

# JSON data for posts
posts_data = [
  { content: 'The only limit to our realization of tomorrow will be our doubts of today. <img src="https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80" />', user_id: 1, visibility: 'public' },
  { content: "Life is what happens when you're busy making other plans. <img src='https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_teaser_image/2020-10/purposeoflife.jpg?itok=G_3RzDjy' />", user_id: 2, visibility: 'friends' },
  { content: 'Success is not final, failure is not fatal: It is the courage to continue that counts.', user_id: 1, visibility: 'public' },
  { content: 'The greatest glory in living lies not in never falling, but in rising every time we fall.', user_id: 2, visibility: 'friends' },
  { content: 'The only way to do great work is to love what you do.', user_id: 1, visibility: 'public' },
  { content: "In three words I can sum up everything I've learned about life: It goes on.", user_id: 2, visibility: 'private' },
  { content: 'You have within you right now, everything you need to deal with whatever the world can throw at you.', user_id: 1, visibility: 'public' },
  { content: 'Life is really simple, but we insist on making it complicated. <img src="https://media.simplemindfulness.com/wp-content/uploads/2018/01/Purpose-of-Life-e1457292794941.jpg" />', user_id: 2, visibility: 'friends' },
  { content: 'The purpose of our lives is to be happy. <img src="https://www.hecktictravels.com/wp-content/uploads/2019/01/Top-of-the-World-Highway-Yukon-Fall.jpg" />', user_id: 1, visibility: 'public' },
  { content: 'Success usually comes to those who are too busy to be looking for it. <img src="https://images.unsplash.com/photo-1584673961397-be26e009333f?q=80&w=2077&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" width="800" />', user_id: 2, visibility: 'private' },
]


# JSON data for comments
comments_data = [
  { content: 'So true! We should always believe in our dreams.', user_id: 1, post_id: 1 },
  { content: 'I completely agree. Doubts hold us back.', user_id: 2, post_id: 1 },
  { content: 'Absolutely, and perseverance is key!', user_id: 1, post_id: 1 },
  { content: 'I find that having a clear goal helps overcome doubts.', user_id: 2, post_id: 1 },
  { content: 'Life is full of surprises!', user_id: 1, post_id: 2 },
  { content: 'Indeed, unexpected events shape our journey.', user_id: 2, post_id: 2 },
  { content: 'Success is a journey, not a destination.', user_id: 1, post_id: 3 },
  { content: 'Each failure is a stepping stone to success.', user_id: 2, post_id: 3 },
  { content: 'I believe in learning from mistakes.', user_id: 1, post_id: 3 },
  { content: 'Rising after a fall is where true strength lies.', user_id: 2, post_id: 3 },
]

# Seed Users
users_data.each do |user|
  User.create!(user)
end

# Seed Posts
posts_data.each do |post|
  created_post = Post.create!(post)

  # Seed Comments for each Post
  rand(1..3).times do
    Comment.create!(
      content: "This is insightful! #{Faker::Lorem.sentence}",
      user_id: [1, 2].sample,
      post: created_post
    )
  end

  # Seed Likes for each Post
  [1, 2].each do |user_id|
    created_post.likes.create!(user_id: user_id)
  end
end

# Seed additional Comments
comments_data.each do |comment|
  Comment.create!(comment)
end
