# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "uri"
require "net/http"
require "pry"

def request_data(uri)
	url = URI(uri)

	https = Net::HTTP.new(url.host, url.port)
	https.use_ssl = true

	request = Net::HTTP::Get.new(url)
	request["Content-Type"] = "application/json"

	https.request(request).body
end

response = request_data("https://randomuser.me/api?format=json&results=30&inc=gender,name,email,Picture&nat=br&seed=giga")
response = JSON.parse(response)["results"]

usuarios = []
imagens = []

response.each do |item|
	usuarios << {
		usuario: Usuario.new(
							genero: item["gender"],
							nome: "#{item["name"]["title"]} #{item["name"]["first"]} #{item["name"]["last"]}",
							email: item["email"]
		),
		imagens: [
			{arquivo: item["picture"]["large"], nome: item["picture"]["large"].gsub(/\.jpg/,'_large.jpg').split('/').last},
			{arquivo: item["picture"]["medium"], nome: item["picture"]["medium"].gsub(/\.jpg/,'_medium.jpg').split('/').last},
			{arquivo: item["picture"]["thumbnail"], nome: item["picture"]["thumbnail"].gsub(/\.jpg/,'_thumb.jpg').split('/').last}
		]
	}
end

usuarios.each do |usuario|
	usuario[:imagens].each do |imagem|
		url = URI("#{imagem[:arquivo]}")
		imagem[:arquivo] = request_data(url)
	end
end

usuarios.each do |usuario|
	if usuario[:usuario].save
		usuario[:imagens].each do |imagem|
			Imagem.create(
				usuario_id: usuario[:usuario].id,
				arquivo: imagem[:arquivo],
				nome: imagem[:nome]
			)
		end
	end
end