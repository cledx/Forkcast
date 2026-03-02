USERS = [["koji@lewagon.com", "Koji the Quiet"], ["katherine@lewagon.com", "Katherine the Stinky"], ["glau@lewagon.com", "Glau the Nice"], ["carlos@lewagon.com", "Carlos the Magnificent"]]
ALLERGIES = ["Shellfish", "Eggs", "Gluten", "Peanuts", "Dairy"]


4.times do |i|
  allergies = rand(1, 3)
  User.create({
    email: USERS[i][0],
    username: USERS[i][1],
    password: 123456,
    

  })