defmodule RAL do
  # Check whether the RAL is empty.
  def empty?([]), do: true
  def empty?(_), do: false

  # Add to front (cons): insert element x at the front of the RAL.
  def cons(x, []), do: [{1, {x, nil, nil}}]
  def cons(x, [{1, t1}, {1, t2} | rest]),
    do: [{2, {x, t1, t2}} | rest]
  def cons(x, rest), do: [{1, {x, nil, nil}} | rest]

  # Return the first element (head) of the RAL.
  def head([{_, {x, _, _}} | _]), do: x

  # Remove the first element (tail) of the RAL.
  def tail([{2, {_, t1, t2}} | rest]),
    do: [{1, t1}, {1, t2} | rest]
  # If leading tree has size 2, drop the first tree and return the rest.
  def tail([_ | rest]), do: rest

  # Lookup an element by index i across the sequence of trees.
  def lookup(r, i), do: lookup_tree(r, i)

  defp lookup_tree([], _), do: :out_of_bounds
  defp lookup_tree([{size, tree} | rest], i) do
    if i < size, do: lookup_in_tree(tree, i),
    else: lookup_tree(rest, i - size)
  end

  # Find element inside a single tree. Index 0 maps to the root value.
  defp lookup_in_tree({x, _, _}, 0), do: x
  defp lookup_in_tree({_, l, r}, i) do
    left_size = count(l)
    if i <= left_size do
      lookup_in_tree(l, i - 1)
    else
      lookup_in_tree(r, i - left_size - 1)
    end
  end

  # Update an element at index i with value v.
  def update(r, i, v), do: update_tree(r, i, v)

  defp update_tree([], _, _), do: :out_of_bounds
  defp update_tree([{size, tree} | rest], i, v) do
    if i < size do
      [{size, update_in_tree(tree, i, v)} | rest]
    else
      [{size, tree} | update_tree(rest, i - size, v)]
    end
  end

  defp update_in_tree({_, l, r}, 0, v), do: {v, l, r}
  defp update_in_tree({x, l, r}, i, v) do
    left_size = count(l)
    if i <= left_size do
      {x, update_in_tree(l, i - 1, v), r}
    else
      {x, l, update_in_tree(r, i - left_size - 1, v)}
    end
  end

  # Count nodes in a tree
  defp count(nil), do: 0
  defp count({_, l, r}), do: 1 + count(l) + count(r)

  # Convert the RAL into a flat list (in-order traversal across each tree).
  def to_list(r), do:
  Enum.flat_map(r, fn {_, t} -> tree_to_list(t) end)

  defp tree_to_list(nil), do: []
  defp tree_to_list({x, l, r}),
  do: [x] ++ tree_to_list(l) ++ tree_to_list(r)

  # Build a RAL from a regular list.
  def from_list(list), do:
  Enum.reduce(Enum.reverse(list),
  [], fn x, acc -> cons(x, acc) end)
end

# Tests
ral = RAL.from_list([1, 2, 3, 4])
IO.inspect RAL.to_list(ral)
IO.inspect RAL.lookup(ral, 2)
IO.inspect RAL.update(ral, 2, 99) |> RAL.to_list()
IO.inspect RAL.empty?(ral)
IO.inspect RAL.head(ral)
IO.inspect RAL.tail(ral) |> RAL.to_list()
