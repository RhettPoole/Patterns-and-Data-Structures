defmodule Q do
  def empty?({[], []}), do: true
  def empty?(_), do: false

  def enqueue({[], []}, e), do: {[e], []}
  def enqueue({f, r}, e), do: {f, [e | r]}

  #Case 2: "when front list has exactly ONE element (matched with [_]) and r is any rear list". Reverse the rear list and makes it the new front list.
  def dequeue({[], []}), do: {[], []}
  def dequeue({[_], r}), do: {Enum.reverse(r), []}
  def dequeue({[_ | t], r}), do: {t, r}

  def head({[], []}), do: nil
  def head({[], r}), do: List.last(r)
  def head({[h | _], _}), do: h

  def tail({[], []}), do: nil
  def tail({f, []}), do: List.last(f)
  def tail({_, [h | _]}), do: h

  # Combining the lists inside of the queue to one list, and converting from list to a queue
  def to_list({f, r}), do: f ++ Enum.reverse(r)
  def from_list(list), do: {list, []}
end

# --------------------------
# Minimal Test Output
# --------------------------

q0 = Q.from_list([])
IO.inspect(q0, label: "q0 (empty queue)")

q1 = Q.enqueue(q0, 1)
q2 = Q.enqueue(q1, 2)
q3 = Q.enqueue(q2, 3)
IO.inspect(Q.to_list(q3), label: "q3 after enqueue 1, 2, 3")

IO.puts("Head of q3: #{Q.head(q3)}")   # Should be 1
IO.puts("Tail of q3: #{Q.tail(q3)}")   # Should be 3

q4 = Q.dequeue(q3)
IO.inspect(Q.to_list(q4), label: "q4 after 1 dequeue")

q5 = Q.dequeue(q4)
IO.inspect(Q.to_list(q5), label: "q5 after 2 dequeues")

q6 = Q.dequeue(q5)
IO.inspect(Q.to_list(q6), label: "q6 after 3 dequeues (should be empty)")

IO.puts("Is q6 empty? #{Q.empty?(q6)}") # true
