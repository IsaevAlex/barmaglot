# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

WomanCategory.create([{name:"Платья"},{name:"Топы и футболки"},{name:"Нижнее белье"},{name:"Толстовки и кофты"},{name:"Свитеры"},{name:"Блузки и рубашки"},{name:"Аксесуары"},{name:"Комбинезоны"},{name:"Чулочно-носочные изделия"},{name:"Куртки и пальто"},{name:"Низ"},{name:"Пиджаки и костюмы"}])
ManCategory.create([{name:"Толстовки и кофты"},{name:"Низ"},{name:"Нижнее белье"},{name:"Костюмы и блейзеры"},{name:"Носки"},{name:"Топы и футболки"},{name:"Рубашки"},{name:"Аксессуары"},{name:"Сон и отдых"},{name:"Куртки и пальто"},{name:"Джинсы"},{name:"Свитера"},{name:"Шорты"}])
ClotherSize.create([{name:"XS"},{name:"S"},{name:"M"},{name:"L"},{name:"XL"},{name:"XXL"},{name:"XXXL"}])