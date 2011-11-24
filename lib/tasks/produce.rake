namespace :assets do
  desc "Installs some random data"
  task :produce do
    branch_name = %x{git symbolic-ref HEAD 2>/dev/null}
    system 'git checkout production && git merge master'
    Rake::Task['assets:precompile'].invoke
    system 'git add public/assets && git commit -m "Compiled assets for production."'
    system "git checkout #{branch_name}" unless branch_name.length == 0
    true
  end
end
