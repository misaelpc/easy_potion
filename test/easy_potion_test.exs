defmodule EasyPotionTest do
  use ExUnit.Case
  doctest EasyPotion

  test "greets the world" do
    assert EasyPotion.hello() == :world
  end
end
