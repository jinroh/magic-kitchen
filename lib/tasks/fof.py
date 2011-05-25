import redis, collections, sys
r=redis.Redis(sys.argv[1])
user_id=sys.argv[2]
friends=r.smembers('User:'+user_id+':following')
c=collections.Counter()
for user in friends:
  c=c+collections.Counter(r.smembers('User:'+user+':following'))
for user in friends:
  del c[user]
del c[user_id]
for i in c.most_common(10):
  r.rpush('User:'+user_id+':following_recommandations',str(i[0])+':'+str(i[1]))
  r.ltrim('User:'+user_id+':following_recommandations',0,9)