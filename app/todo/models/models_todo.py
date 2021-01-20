from ext.database import Base
from .audit_mixins import AuditMixin
from sqlalchemy import Column, String, Integer, Boolean, DateTime


class Task(Base, AuditMixin):
    import pydevd_pycharm
    pydevd_pycharm.settrace('localhost', port=8787, stdoutToServer=True, stderrToServer=True)
    id = Column(Integer, primary_key=True)
    name = Column(String, default="unnamed")
    completed = Column(Boolean, default=False)

    updated_on_gateway = Column(
        Boolean, nullable=False, default=False, server_default="0"
    )
    updated_on_gateway_at = Column(DateTime, nullable=True)
