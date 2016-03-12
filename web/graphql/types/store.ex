defmodule App.Type.Store do

  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType

  alias GraphQL.Relay.Node
  alias GraphQL.Relay.Connection
  alias GraphQL.Relay.Mutation
  import RethinkDB.Query, only: [table: 1]

  def get do
    %ObjectType{
      name: "Store",
      fields: %{
        id: Node.global_id_field("store"),
        linkConnection: %{
          type: App.Type.LinkConnection.get[:connection_type],
          args: Connection.args,
          resolve: fn ( _, args , _ctx) ->
            query = table("links")
              |> DB.run
              |> DB.handle_graphql_resp
            Connection.List.resolve(query, args)
          end
        }
      }
    }
  end
end