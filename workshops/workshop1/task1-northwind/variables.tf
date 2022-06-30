
variable nwdb-image {
    type = string
    default = "stackupiss/northwind-db:v1"
}

variable nwdb-port {
    type = number
    default = 3306
}

# variable nw_images {
#     type = map(object{
#         image_name = string
#         port = number
#     })

#     default = {
#         nwdb = {
#             image_name = "stackupiss/northwind-db:v1"
#             port = 3306
#         }
#         nwapp = {
#             image_name = "stackupiss/northwind-app:v1
#             port = 3000
#         }
#     }
# }