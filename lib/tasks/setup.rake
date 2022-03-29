namespace :setup do
	desc "Cria diretório de imagens caso não exista"
	task :cria_diretorio_imagens do |task|
		Dir.mkdir('public/images') if !Dir.exists?('public/images')
		p Dir['public']
	end

	desc "Consome api e adiciona dados no banco"
	task consome_api: :environment do
		
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
	end
end