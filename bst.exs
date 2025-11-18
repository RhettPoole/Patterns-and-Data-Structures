defmodule BST do
  def empty?(nil), do: true
  def empty?(_), do: false

  def add(nil, e), do: {e, nil, nil}
  def add({v, l, r}, e) when e < v,
    do: {v, add(l, e), r}
  def add({v, l, r}, e),
    do: {v, l, add(r, e)}

  def contains?(nil, _), do: false
  def contains?({v, _, _}, e) when e == v, do: true
  def contains?({v, l, _}, e) when e < v, do: contains?(l, e)
  def contains?({_, _, r}, e), do: contains?(r, e)

  def min(nil), do: nil
  def min({v, nil, _}), do: v
  def min({_, l, _}), do: min(l)

  def max(nil), do: nil
  def max({v, _, nil}), do: v
  def max({_, _, r}), do: max(r)

end
