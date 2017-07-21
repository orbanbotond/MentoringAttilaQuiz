# curl 'localhost:9200/question/_search?q=hany&pretty'

# curl -XPOST 'localhost:9200/question/_search?pretty' -d '
# {
#   "query": {
#     "match": {
#       "_all":    "Hany kereke van egy autonak?"
#     }
#   }
# }'

# curl 'localhost:9200/_cat/indices/*?v&s=index'

# curl http://localhost:9200/global_search/meeting/1

# count documents:
# curl -XGET 'localhost:9200/test_global_search/learning/_count?pretty'

# curl -XGET 'localhost:9200/_analyze?pretty' -H 'Content-Type: application/json' -d'
# {
#   "analyzer" : {"tokenizer":{"my_tokenizer":{"type":"nGram","min_gram":"1","max_gram":"25"}},"analyzer":{"meeteor":{"filter":["meeteor_ngram"],"tokenizer":"standard"}}},
#   "text" : "this is a test"
# }
# '

curl -XGET 'localhost:9200/_analyze?pretty' -H 'Content-Type: application/json' -d'
{ 
    "analyzer" : {
            "name_analyzer" : {
              "filter" : [ "lowercase", "asciifolding" ],
              "tokenizer" : {"my_tokenizer": {"token_chars" : [ "letter", "digit" ], "min_gram" : "1", "type" : "ngram", "max_gram" : "25"}}
            }
          },
  "text" : "this is a test"
}'

curl -XGET 'localhost:9200/_analyze?pretty' -H 'Content-Type: application/json' -d'
{
  "analyzer" : "name_analyzer",
  "text" : "this is a test"
}
'


# Retrieve the index itself
# curl -XGET 'http://localhost:9200/global_search/_settings?pretty'

# curl -XPOST 'localhost:9200/question/_analyze?pretty' -H 'Content-Type: application/json' -d'
# {
#   "analyzer": "name_analyzer",
#   "text": "this is a text"
# }
# '

# Retrieve the index
# curl -XGET 'localhost:9200/question?pretty'

# retieve mapping:
# curl -XGET 'localhost:9200/question/_mapping?pretty'

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