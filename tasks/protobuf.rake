namespace :protobuf do
  task :compile do
    sh 'protoc --ruby_out=lib -I proto ./proto/*.proto'
  end
end
