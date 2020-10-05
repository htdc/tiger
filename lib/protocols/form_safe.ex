defprotocol FormSafe do
  def encode(incoming)
end

defimpl FormSafe, for: Map do
  def encode(incoming) when is_map(incoming) do
    incoming
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end
end

defimpl FormSafe, for: Any do
  def encode(incoming) when is_struct(incoming) do
    Map.from_struct(incoming)
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end
end

defimpl FormSafe, for: BitString do
  def encode(incoming) when is_binary(incoming) do
    incoming
  end
end

defimpl FormSafe, for: Atom do
  def encode(atom), do: atom
end
