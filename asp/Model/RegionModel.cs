using System;
namespace zcw.Model
{
	/// <summary>
	/// RegionModel:ʵ����(����˵���Զ���ȡ���ݿ��ֶε�������Ϣ)
	/// </summary>
	[Serializable]
	public partial class RegionModel
	{
		public RegionModel()
		{}
		#region Model
		private int _myid;
		private string _ʡ�е������;
		private string _ʡ�е�������;
		private string _ʡ�е�������;
		private string _����������;
		private string _������������;
		private string _��ע;
		private string _dq_id;
		private DateTime? _updatetime;
		/// <summary>
		/// 
		/// </summary>
		public int myID
		{
			set{ _myid=value;}
			get{return _myid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ʡ�е������
		{
			set{ _ʡ�е������=value;}
			get{return _ʡ�е������;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ʡ�е�������
		{
			set{ _ʡ�е�������=value;}
			get{return _ʡ�е�������;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ʡ�е�������
		{
			set{ _ʡ�е�������=value;}
			get{return _ʡ�е�������;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ����������
		{
			set{ _����������=value;}
			get{return _����������;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ������������
		{
			set{ _������������=value;}
			get{return _������������;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string ��ע
		{
			set{ _��ע=value;}
			get{return _��ע;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string dq_id
		{
			set{ _dq_id=value;}
			get{return _dq_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? updatetime
		{
			set{ _updatetime=value;}
			get{return _updatetime;}
		}
		#endregion Model

	}
}

