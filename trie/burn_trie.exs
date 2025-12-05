defmodule Trie do
  # Make new trie now
  def new, do: %{end?: false, children: %{}}

  # Determine whether empty
  def empty?(%{end?: false, children: c}),
    do: map_size(c) == 0
  def empty?(_), do: false

  # Base case
  def add(trie, []), do: %{trie | end?: true}

  # Rcursive add, if doesn't exist, create one
  def add(%{children: c} = trie, [h | t]) do
    child = Map.get(c, h, new())
    %{trie | children: Map.put(c, h, add(child, t))}
  end

  # Check for sequence
  def contains?(%{end?: e}, []), do: e

  # Keep walking down the children until list is finished
  def contains?(%{children: c}, [h | t]) do
    case Map.get(c, h) do
      nil -> false
      sub -> contains?(sub, t)
    end
  end

  # Remove, once we hit the end just unmark
  def remove(trie, []), do: %{trie | end?: false}

  # Recursive remove, check if it's empty
  def remove(%{children: c} = trie, [h | t]) do
    case Map.get(c, h) do
      nil ->
        trie

      sub ->
        updated = remove(sub, t)
        new_c = if empty?(updated),
do: Map.delete(c, h), else: Map.put(c, h, updated)
        %{trie | children: new_c}
    end
  end

  # Return stored sequences that begin with 'prefix'
  def prefix(trie, prefix), do: pre(trie, prefix, [])
  # Once prefix matches completely, gather all completions from here
  defp pre(trie, [], acc), do: collect(trie, acc)

  # Keep descending the tree
  defp pre(%{children: c}, [h | t], acc) do
    case Map.get(c, h) do
      nil -> []
      sub -> pre(sub, t, acc ++ [h])
    end
  end

  # Converts the entire trie back into a list
  def to_list(trie), do: collect(trie, [])

  # Gather all sequences that are reachable from the current node. Build using accumulator.
  defp collect(%{end?: e, children: c}, acc) do
    words = for {ch, sub} <- c, into: [],
      do: collect(sub, acc ++ [ch])
    # If current node is endpoint, include the accumulated word.
    if e, do: [acc | List.flatten(words)],
      else: List.flatten(words)
  end

  # Builds a trie from a list
  def from_list(list),
    do: Enum.reduce(list, new(), &add(&2, &1))
end

# -----------------------
# Test cases

t = Trie.new()
t = Trie.add(t, ~c"cat")
t = Trie.add(t, ~c"car")
t = Trie.add(t, ~c"dog")

IO.puts("Contains 'cat'? #{Trie.contains?(t, ~c"cat")}")
IO.puts("Contains 'can'? #{Trie.contains?(t, ~c"can")}")

IO.inspect(Trie.prefix(t, ~c"ca"), label: "Prefix 'ca'")
IO.inspect(Trie.to_list(t), label: "To List")

t = Trie.remove(t, ~c"car")
IO.inspect(Trie.to_list(t), label: "After removing 'car'")
