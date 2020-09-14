# frozen_string_literal: true

# Git interface
class Git
  ## clone project
  def clone(url, folder)
    system("git clone #{url} #{folder}")
  end

  ## pull project
  def pull(folder)
    Dir.chdir(folder) { system('git pull') }
  end

  # archive project
  def archive(repo, to)
    puts "Archiving: #{repo} to #{to}"
  end
end
