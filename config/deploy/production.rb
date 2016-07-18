set :branch, 'master'

server(
  'ec2-52-28-165-36.eu-central-1.compute.amazonaws.com',
  user: 'deployer',
  roles: %w(web app db)
)
