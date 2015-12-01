#! /usr/bin/env python
# coding: utf-8
import sys
import urllib2
import time
import json
import requests

reload(sys)
sys.setdefaultencoding('utf-8')

title = sys.argv[2]
content = sys.argv[3]

class Token(object):
    #get access_token
    def __init__(self, corpid, corpsecret):
        self.baseurl = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}'.format(corpid, corpsecret)
        self.expire_time = sys.maxint

    def get_token(self):
        if self.expire_time > time.time():
            request  = urllib2.Request(self.baseurl)
            response = urllib2.urlopen(request)
            ret = response.read().strip()
            ret = json.loads(ret)
            if 'errcode' in ret.keys():
                print >> ret['errmsg'], sys.stderr
                sys.exit(1)
            self.expire_time  = time.time() + ret['expires_in']
            self.access_token = ret['access_token']
        return self.access_token

def send_msg(title, content):
    corpid = "**********************"
    corpsecret = "*************************"
    qs_token = Token(corpid=corpid, corpsecret=corpsecret).get_token()
    url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={0}".format(qs_token)
    payload = {
        "touser" : "@all",
        "msgtype": "text",
        "agentid": "1",
        "text": {
            "content": "{0}\n{1}".format(title, content)
        },
        "safe": "0"
    }
    ret = requests.post(url, data=json.dumps(payload, ensure_ascii=False))
    print ret.json()

if __name__ == '__main__':
    send_msg(title, content)
