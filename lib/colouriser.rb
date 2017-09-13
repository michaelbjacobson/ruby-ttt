# Monkey patching new methods onto Ruby's built-in String class
class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end
end
