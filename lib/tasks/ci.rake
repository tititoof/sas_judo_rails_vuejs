namespace :ci do
  task :all => ["ci:test", "rspec"]
end