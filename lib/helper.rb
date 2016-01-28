helpers do
  def are_you?(what, action)
    what.split('/').last == action
  end
end
