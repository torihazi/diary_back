def create_user(i)
  User.new(
    name: "user#{i + 1}",
    email: "user#{i + 1}@mail.com",
    password: "password#{i + 1}",
    jti: SecureRandom.uuid
  )
end

def create_diary(user, j)
  user.diaries.build(
    title: "Diary #{j + 1} of #{user.name}",
    content: "Content for diary #{j + 1} of #{user.name}"
  )
end

5.times do |i|

  user = create_user(i)
  user.skip_confirmation!
  
  if user.save
    3.times do |j|
      diary = create_diary(user,j)
      if diary.save
        puts "create #{diary.title}"
      else
        puts "failed to create diary#{j + 1}"
      end
    end
  else
    puts "failed to create user#{i + 1}"
  end

end