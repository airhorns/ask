namespace :demo do
  desc "Installs some random data"
  task :produce do
    branch_name = system "git symbolic-ref HEAD 2>/dev/null"
    puts system 'git checkout production && git merge master'
    Rake::Task['assets:precompile'].invoke
    puts system 'git add public/assets && git commit -m "Compiled assets for production."'
    puts system "git checkout #{branch_name}" unless branch_name.length == 0
    true
  end
end
