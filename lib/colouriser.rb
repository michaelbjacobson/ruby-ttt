# Monkey patching new #red method onto Ruby's built-in String class
class String
  def red
    "\e[31m#{self}\e[0m"
  end
end