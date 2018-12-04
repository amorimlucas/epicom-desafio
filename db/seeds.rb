# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Exemplo de JSON
#
#{
#   "tipo": "criacao_sku",
#   "dataEnvio": "2015-08-18T20:51:22",
#   "parametros": {
#     "idProduto": 270229,
#     "idSku": 322358
#   }
# }

records = JSON.parse(File.read('db/criacao_sku.json'))
records.each do |record|
  Sku.create({
  	idProduto: record["parametros"]["idProduto"],
  	idSku: record["parametros"]["idSku"],
  })
end