class Hash

  # Write a version of merge. This should NOT modify the original hash
  def my_merge(hash2)
    h = self.dup

    hash2.each { |k, v| h[k] = v }

    h
  end

end
