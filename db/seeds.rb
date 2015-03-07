Coord.create!([
  {lat: "43.659891", lng: "-79.358625", device_id: 1, state: "journey"},
  {lat: "43.657891", lng: "-79.368625", device_id: 1, state: "journey"},
  {lat: "43.654891", lng: "-79.388625", device_id: 1, state: "journey"},
  {lat: "43.654891", lng: "-79.388625", device_id: 1, state: "alert"},
  {lat: "43.653891", lng: "-79.386625", device_id: 1, state: "alert"}
])
Device.create!([
  {name: "Penny-farthing", user_id: 1}
])
User.create!([
  {name: "Kirkpatrick Macmillan", email: "joyride@gmail.com", meta: {"text_notification"=>"4168418601", "email_notification"=>"joyride@gmail.com"}}
])
