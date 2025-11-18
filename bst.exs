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

  def remove(nil, _), do: nil
  def remove({v, l, r}, e) when e < v,
    do: {v, remove(l, e), r}
  def remove({v, l, r}, e) when e > v,
    do: {v, l, remove(r, e)}

  def remove({v, l, r}, v) do
    cond do
      l == nil -> r
      r == nil -> l
      true ->
        successor = min(r)
        {successor, l, remove(r, successor)}
    end
  end

  def to_list(nil), do: []
  def to_list({v, l, r}),
    do: to_list(l) ++ [v] ++ to_list(r)

  def from_list(list),
    do: Enum.reduce(list, nil, fn x, acc -> add(acc, x) end)

  def height(nil), do: 0
  def height({_, l, r}),
    do: 1 + max(height(l), height(r))

  def is_balanced?(nil), do: true
  def is_balanced?({_, l, r}) do
    abs(height(l) - height(r)) <= 1 and
    is_balanced?(l) and
    is_balanced?(r)
  end
end

# Testing
tree = nil
tree = BST.add(tree, 10)
tree = BST.add(tree, 5)
tree = BST.add(tree, 15)

IO.inspect(BST.empty?(nil), label: "Empty?")
IO.inspect(BST.contains?(tree, 5), label: "Contains 5?")
IO.inspect(BST.contains?(tree, 99), label: "Contains 99?")

IO.inspect(BST.min(tree), label: "Min")
IO.inspect(BST.max(tree), label: "Max")

IO.inspect(BST.to_list(tree), label: "To list")
IO.inspect(BST.from_list([3, 1, 4]), label: "From list")

IO.inspect(BST.height(tree), label: "Height")
IO.inspect(BST.is_balanced?(tree), label: "Balanced?")

tree = BST.remove(tree, 5)
IO.inspect(BST.to_list(tree), label: "After removing 5")

tree = BST.remove(tree, 10)
IO.inspect(BST.to_list(tree), label: "After removing 10")

tree = BST.remove(tree, 15)
IO.inspect(BST.empty?(tree), label: "Is it empty?")
