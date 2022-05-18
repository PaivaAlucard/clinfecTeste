### Contato
* bieltdb20@gmail.com


## Banco de dados
MySql - Script de banco em database\queries.sql
* Coluna 'Ativo' representa exclusão lógica dos dados

## Tecnologias
* JWT + Node + MySql + Express

## Executando o server: 

cd server

npm install dotenv

npm install 

node server


### Pelo postman fazer um GET em http://localhost:3000/v1/users/login

* preencher body do GET com:

`{
	"email": "bieltdb20@gmail.com",
	"password": "bieltdb20"
}`

* pegar a chave de autenticação JWT retornada e usar nos outros serviços 

## no postman GET no paciente

http://localhost:3000/v1/paciente

* escolher Authorization OAuth 2.0

* preencher o access token com a chave retornada sem aspas na API users/login
header prefix Bearer

## retorno da API:

`[
    {
        "idPacienteClinfec": 1,
        "nome": "Junior",
        "sobreNome": "Lima",
        "dataDeNascimento": "2098-01-23T12:45:56.000Z",
        "cpf": "03718758112",
        "idConsultaClinfec_fk": 1,
        "ativo": 1
    },
    {
        "idPacienteClinfec": 2,
        "nome": "Pedro",
        "sobreNome": "Junior",
        "dataDeNascimento": "2008-01-23T12:45:56.000Z",
        "cpf": "13718758112",
        "idConsultaClinfec_fk": 2,
        "ativo": 1
    }
]`

## no postman GET na consulta

http://localhost:3000/v1/consulta

* escolher Authorization OAuth 2.0

* preencher o access token com a chave retornada sem aspas na API users/login
header prefix Bearer

## retorno da API:
`[
    {
        "idConsultaClinfec": 1,
        "dataConsulta": "2098-01-23T12:45:56.000Z",
        "idMedicoClinfec_fk": 1,
        "idPacienteClinfec_fk": 1,
        "ativo": 1
    },
    {
        "idConsultaClinfec": 2,
        "dataConsulta": "2008-01-23T12:45:56.000Z",
        "idMedicoClinfec_fk": 2,
        "idPacienteClinfec_fk": 2,
        "ativo": 1
    }
]`

## no postman GET no paciente

http://localhost:3000/v1/paciente

* escolher Authorization OAuth 2.0

* preencher o access token com a chave retornada sem aspas na API users/login
header prefix Bearer

## retorno da API:
`[
    {
        "idPacienteClinfec": 1,
        "nome": "Junior",
        "sobreNome": "Lima",
        "dataDeNascimento": "2098-01-23T12:45:56.000Z",
        "cpf": "03718758112",
        "idConsultaClinfec_fk": 1,
        "ativo": 1
    },
    {
        "idPacienteClinfec": 2,
        "nome": "Pedro",
        "sobreNome": "Junior",
        "dataDeNascimento": "2008-01-23T12:45:56.000Z",
        "cpf": "13718758112",
        "idConsultaClinfec_fk": 2,
        "ativo": 1
    }
]`