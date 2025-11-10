# In your editor, implement the following functions for a functional queue using the structure {list, list} (a front list and a rear list):

defmodule Q do
  #empty(queue)
  #Input: A queue
  #Output: true if the queue is empty, false otherwise
  def empty?({[], []}), do: true
  def empty?(_), do: false

  # enqueue(queue, element)
  # Input: A queue and an element
  #Output: A new queue with the element added to the rear
  def enqueue({[], []}, e), do: {[e] , []}
  def enqueue({f, r}, e), do: {f, [e | r]}

  # dequeue(queue)
  # Input: A queue
  #Output: A new queue with the first element removed
  def dequeue({[], []}), do: {[], []}
  def dequeue({[_], r}), do: {Enum.reverse(r), []}
  def dequeue({[_ | t], r}), do: {t, r}

  # head(queue)
  # Input: A queue
  # Output: The first element or nil if the queue is empty
  def head({[], []}), do: nil
  def head({[], r}), do: List.last(r)
  def head({[h | _], _}), do: h

  # tail(queue)
  # Input: A queue
  # Output: The last element or nil if the queue is empty
  def tail({[], []}), do: nil
  def tail({f, []}), do: List.last(f)
  def tail({_, [h | _]}), do: h

  # toList(queue)
  # Input: A queue
  # Output: A list of elements in order
  def to_list({f, r}), do: f ++ Enum.reverse(r)

  # fromList(list)
  # Input: A list of elements
  # Output: A queue
  def from_list(list), do: {list, []}
end

# Testing
# ----------

q0 = Q.from_list([])
IO.inspect(q0, label: "q0 (empty queue)")

q1 = Q.enqueue(Q0, 1)
q2 = Q.enqueue(q1, 2)
q3 = Q.enqueue(q2, 3)
IO.inspect(Q.to_lit(q3), label: "q3 after enqueue 1, 2, 3")

IO.puts("Head of q3: #{Q.head(q3)}")
IO.puts("Tail of q3: #{Q.tail(q3)}")

q4 = Q.dequeue(q3)
IO.inspect(Q.to_list(q4), lable: "q4 after 1 dequeue")

q5 = Q.dequeue(q4)
IO.inspect(Q.to_list(q5), lable: "q5 after 2 dequeues")

q6 = Q.dequeue(q5)
IO.inspect(Q.to_list(q6), lable: "q6 after 3 dequeues (should be empty)")

IO.puts("Is q6 empty? #{Q.empty?(q6)}")
