using System;
namespace zcw.Model
{
	/// <summary>
	/// RegionModel:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class RegionModel
	{
		public RegionModel()
		{}
		#region Model
		private int _myid;
		private string _省市地区编号;
		private string _省市地区名称;
		private string _省市地区简码;
		private string _所属区域编号;
		private string _所属区域名称;
		private string _备注;
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
		public string 省市地区编号
		{
			set{ _省市地区编号=value;}
			get{return _省市地区编号;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string 省市地区名称
		{
			set{ _省市地区名称=value;}
			get{return _省市地区名称;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string 省市地区简码
		{
			set{ _省市地区简码=value;}
			get{return _省市地区简码;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string 所属区域编号
		{
			set{ _所属区域编号=value;}
			get{return _所属区域编号;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string 所属区域名称
		{
			set{ _所属区域名称=value;}
			get{return _所属区域名称;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string 备注
		{
			set{ _备注=value;}
			get{return _备注;}
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

