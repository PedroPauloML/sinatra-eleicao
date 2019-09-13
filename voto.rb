require 'sinatra'
require 'yaml/store'

# Routes
get '/' do
  @titulo = 'Bem vindo a Eleição'
  erb :index
end

post '/cast' do
  @titulo = 'Obrigada por votar!'
  @voto  = params['voto']
  @store = YAML::Store.new 'votos.yml'
  @store.transaction do
    @store['votos'] ||= {}
    @store['votos'][@voto] ||= 0
    @store['votos'][@voto] += 1
  end
  erb :cast
end

get '/results' do
  @titulo = 'Resultados até agora:'
  @store = YAML::Store.new 'votos.yml'
  @votos = @store.transaction { @store['votos'] }
  erb :results
end

# Global Variables
SiteName = "Eleição"
Opcoes = {
  'HAM' => 'Hambúrger',
  'PIZ' => 'Pizza',
  'SUS' => 'Sushi',
  'LAM' => 'Lámen',
}