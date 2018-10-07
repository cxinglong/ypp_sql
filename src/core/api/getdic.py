import logging
import ast
from libs import baseview
from core.task import grained_permissions
from libs import util
from rest_framework.response import Response
from django.http import HttpResponse
from libs.serializers import Sqllist
from core.models import (
    DatabaseList,
    SqlDictionary
)

CUSTOM_ERROR = logging.getLogger()


class get_dic(baseview.BaseView):

    '''

    :argument 数据库管理页面api 接口

    '''

    @grained_permissions
    def get(self, request, args=None):

        '''

        :argument 管理页面数据展示

        :return

                {
                        'page': page_number,
                        'data': serializers.data,
                        'diclist': data,
                        'ding_switch': switch_dingding,
                        'mail_switch': switch_email
                }

        '''

        try:
            page = request.GET.get('page')
        except KeyError as e:
            CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
            return HttpResponse(status=500)
        else:
            try:
                un_init = util.init_conf()
                custom_com = ast.literal_eval(un_init['other'])
                page_number = DatabaseList.objects.count()
                start = int(page) * 10 - 10
                end = int(page) * 10
                info = DatabaseList.objects.all().order_by('connection_name')[start:end]
                serializers = Sqllist(info, many=True)
                data = SqlDictionary.objects.all().values('Name')
                data.query.group_by = ['Name']  # 不重复表名

                return Response(
                    {
                        'page': page_number,
                        'data': serializers.data,
                        'diclist': data,
                        'custom': custom_com['con_room']
                    }
                )
            except Exception as e:
                CUSTOM_ERROR.error(f'{e.__class__.__name__}: {e}')
                return HttpResponse(status=500)