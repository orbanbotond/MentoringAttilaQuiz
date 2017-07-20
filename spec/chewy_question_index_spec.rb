# curl 'localhost:9200/question/_search?q=M1&pretty'

# curl -XPOST 'localhost:9200/global_search/_search?pretty' -d '
# {
#   "query": {
#     "match": {
#       "_all":    "M1"
#     }
#   }
# }'

# curl 'localhost:9200/_cat/indices/*?v&s=index'

# curl http://localhost:9200/global_search/meeting/1

# count documents:
# curl -XGET 'localhost:9200/test_global_search/learning/_count?pretty'

# curl -XGET 'localhost:9200/_analyze?pretty' -H 'Content-Type: application/json' -d'
# {
#   "analyzer" : {"filter":{"meeteor_ngram":{"type":"nGram","min_gram":"2","max_gram":"15"}},"analyzer":{"meeteor":{"filter":["meeteor_ngram"],"tokenizer":"standard"}}},
#   "text" : "this is a test"
# }
# '

# Retrieve the index itself
# curl -XGET 'http://localhost:9200/global_search/_settings?pretty'

# curl -XPOST 'localhost:9200/test_global_search/_analyze?pretty' -H 'Content-Type: application/json' -d'
# {
#   "analyzer": "meeteor_index_analyzer",
#   "text": "document.doc"
# }
# '

# Retrieve the index
# curl -XGET 'localhost:9200/question?pretty'

# retieve mapping:
# curl -XGET 'localhost:9200/global_search/_mapping?pretty'

# curl -XGET 'http://localhost:9200/global_search/document/20/_termvector?fields=s3_url'

# curl -XGET 'http://localhost:9200/global_search/meeting/1/_termvector?fields=text_field'

# curl -XGET 'localhost:9200/global_search/meeting/1/_termvectors?pretty' -H 'Content-Type: application/json' -d'
# {
#   "fields" : ["text"],
#   "offsets" : true,
#   "payloads" : true,
#   "positions" : true,
#   "term_statistics" : true,
#   "field_statistics" : true
# }
# '

# curl -XGET 'localhost:9200/global_search/meeting/_search?pretty' -H 'Content-Type: application/json' -d'
# {
#     "query": {
#         "match": {
#             "name": "Lu"
#         }
#     }
# }
# '


# curl -XGET 'localhost:9200/global_search/meeting/_search?pretty' -H 'Content-Type: application/json' -d'
# {
#     "query": {
#         "match": {
#             "name": "Lu"
#         }
#     },
#     "highlight": {
#       fields: {
#         "name": {}
#       }
#     }
# }
# '