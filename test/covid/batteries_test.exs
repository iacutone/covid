defmodule Covid.BatteriesTest do
  use Covid.DataCase

  alias Covid.Batteries

  describe "batteries" do
    alias Covid.Batteries.Battery

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def battery_fixture(attrs \\ %{}) do
      {:ok, battery} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Batteries.create_battery()

      battery
    end

    test "list_batteries/0 returns all batteries" do
      battery = battery_fixture()
      assert Batteries.list_batteries() == [battery]
    end

    test "get_battery!/1 returns the battery with given id" do
      battery = battery_fixture()
      assert Batteries.get_battery!(battery.id) == battery
    end

    test "create_battery/1 with valid data creates a battery" do
      assert {:ok, %Battery{} = battery} = Batteries.create_battery(@valid_attrs)
    end

    test "create_battery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Batteries.create_battery(@invalid_attrs)
    end

    test "update_battery/2 with valid data updates the battery" do
      battery = battery_fixture()
      assert {:ok, %Battery{} = battery} = Batteries.update_battery(battery, @update_attrs)
    end

    test "update_battery/2 with invalid data returns error changeset" do
      battery = battery_fixture()
      assert {:error, %Ecto.Changeset{}} = Batteries.update_battery(battery, @invalid_attrs)
      assert battery == Batteries.get_battery!(battery.id)
    end

    test "delete_battery/1 deletes the battery" do
      battery = battery_fixture()
      assert {:ok, %Battery{}} = Batteries.delete_battery(battery)
      assert_raise Ecto.NoResultsError, fn -> Batteries.get_battery!(battery.id) end
    end

    test "change_battery/1 returns a battery changeset" do
      battery = battery_fixture()
      assert %Ecto.Changeset{} = Batteries.change_battery(battery)
    end
  end
end
