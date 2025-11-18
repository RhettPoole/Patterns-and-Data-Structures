# To run with IEX - iex.bat
# Load it in IEX with c('filename'), then build a tree step-by-step by reassigning a variable and calling its functions to see the results.
# Otherwise, build test suite at bottom of file.

defmodule BST do
   # Empty
  def empty?(nil), do: true
  def empty?(_), do: false

  # Add (Insert)
  # If bst is empty, set element as base value
  def add(nil, e), do: {e, nil, nil}
  # If element is less then value, add to left subtree
  def add({v, l, r}, e) when e < v,
    do: {v, add(l, e), r}
  # Otherwise, add to right subtree.
  def add({v, l, r}, e),
    do: {v, l, add(r, e)}

  # Contains
  # Reach an empty spot? Return false
  def contains?(nil, _), do: false
  # If element = current value return true
  def contains?({v, _, _}, e) when e == v, do: true
  # If element less than current value, search in left subtree
  def contains?({v, l, _}, e) when e < v, do: contains?(l, e)
  # If element greater than current value, search in right subtree.
  def contains?({_, _, r}, e), do: contains?(r, e)

  # Min
  # If tree is empty, return nil
  def min(nil), do: nil
  # If node has no left subtree then current node has smallest value. Return that value
  def min({v, nil, _}), do: v
  # Otherwise keep moving left to find min value.
  def min({_, l, _}), do: min(l)

  # Max
  # If tree is empty, return nil
  def max(nil), do: nil
  # If node has no right subtree, current node is largest value. Return that value
  def max({v, _, nil}), do: v
  # Otherwise keep moving right to find max value.
  def max({_, _, r}), do: max(r)

  # Remove
  # If empty, return Nil
  def remove(nil, _), do: nil
  # If element to remove is smaller than current value, move to left subtree
  def remove({v, l, r}, e) when e < v,
    do: {v, remove(l, e), r}
  # If element to remove is greater than current value, move to right subtree
  def remove({v, l, r}, e) when e > v,
    do: {v, l, remove(r, e)}

  # Case: found node with the value to remove
  def remove({v, l, r}, v) do
    cond do
      # If left child empty, return right
      l == nil -> r
      # If right child empty, return left
      r == nil -> l
      true ->
      # Two children - find successor, replace and remove duplicate
        successor = min(r) # Find smallest value in right tree
        {successor, l, remove(r, successor)} # Replace current with successor and update.
    end
  end

  # To List (in-order)
  # If empty, return empty list
  def to_list(nil), do: []
  # Otherwise make list with v as middle value.
  def to_list({v, l, r}),
    do: to_list(l) ++ [v] ++ to_list(r)

  # From List
  # Take a list, start from an empty tree, and use add to build the BST one value at a time.
  def from_list(list),
    do: Enum.reduce(list, nil, fn x, acc -> add(acc, x) end)

  # Height
  def height(nil), do: 0
  # retreive max height of left or right (whichever is taller) and add 1 to that.
  def height({_, l, r}),
    do: 1 + max(height(l), height(r))

  # Balanced?
  # If empty, true
  def is_balanced?(nil), do: true
  # Non-empty? Calculate the diff between left and right, if less than 1 it's balanced.
  def is_balanced?({_, l, r}) do
    abs(height(l) - height(r)) <= 1 and
    # Check subtrees to see if they are balanced.
      is_balanced?(l) and
      is_balanced?(r)
  end
end

# --------
# Test suite
tree = nil
tree = BST.add(tree, 10)
tree = BST.add(tree, 5)
tree = BST.add(tree, 15)

IO.puts("Empty? #{BST.empty?(nil)}")
IO.puts("Contains 5? #{BST.contains?(tree, 5)}")
IO.puts("Contains 99? #{BST.contains?(tree, 99)}")

IO.puts("Min: #{BST.min(tree)}")
IO.puts("Max: #{BST.max(tree)}")

IO.inspect(BST.to_list(tree), label: "To list")
IO.inspect(BST.from_list([3, 1, 4]), label: "From list")

IO.puts("Height: #{BST.height(tree)}")
IO.puts("Balanced? #{BST.is_balanced?(tree)}")

tree = BST.remove(tree, 5)
IO.inspect(BST.to_list(tree), label: "After removing 5")

tree = BST.remove(tree, 10)
IO.inspect(BST.to_list(tree), label: "After removing 10")

tree = BST.remove(tree, 15)
IO.puts("Empty after all removed? #{BST.empty?(tree)}")
