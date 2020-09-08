class Git
  def clone(url, folder)
  end

  def pull(folder)
  end

  def archive(repo, to)
    puts "Archiving: #{repo} to #{to}"
  end

  def getter(repo, to)
    if to.exist?
      clone(repo, to)
    else
      pull(to)
    end
  end
end
