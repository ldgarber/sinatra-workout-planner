item_list = [
  "kettlebell", "swimming pool", "tennis racket", "tennis ball", "weighted ball", "10lb barbell", "squat rack", "track", "pull-up bar", "ab roller"
]

item_list.each do |item_name|
  Item.create(name: item_name)
end
