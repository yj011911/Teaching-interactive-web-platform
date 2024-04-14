<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 后台教师管理控制器
 * Created by PhpStorm.
 * User: 熠
 * Date: 2015/3/31
 * Time: 17:55
 */
class Admin_list extends CI_Controller
{
    private $assign_arr = array();

    public function __construct()
    {
        parent::__construct();
        $this->common_cls->is_login_alert();
        $this->load->model('admin', 'admin_cls');
        $this->assign_arr['controller_name'] = $this->router->class;
        $this->assign_arr['web_title'] = '教师管理';
        $this->assign_arr['nav_show'] = 'system';
    }

    /**
     * 管理员列表
     * @param int $page 页数
     */
    public function index($page = 1)
    {
        $per_page = 10;//每页10条数据
        //获取管理员列表
        $admin_info_list = $this->admin_cls->get_admin_list($page, $per_page);
        $this->assign_arr['admin_info_list'] = $admin_info_list;
        //分页
        $this->load->library('page_cls');
        $this->assign_arr['page_string'] = $this->page_cls->get_page_config($this, $this->admin_cls->get_admin_count(), true, $per_page);
        //页面展示
        $this->smarty->view('admin/admin_list.tpl', $this->assign_arr);
    }

    /**
     * 添加管理员
     */
    public function add()
    {
        /****权限判断(未完成)*****/
        $user_name = $this->input->post('user_name', true);
        $password = $this->input->post('password_input', true);
        $user_type = $this->input->post('user_type', true);
        $user_status = $this->input->post('user_status', true);
        if (empty($user_name) || empty($password)) {
            echo $this->common_cls->json_output('-2','输入信息不完整!');
            return;
        }
        /***密码策略(未完成)***/
        $user_type = $user_type == '2' ? '2' : '1';
        $user_status = $user_status == '1' ? '1' : '0';
        //用户名已存在
        if ($this->admin_cls->get_counts('user_name = \'' . $user_name . '\'') > 0) {
            echo $this->common_cls->json_output('-4','该用户名已存在!');
            return;
        }
        $this->log->add_log('添加教师(教师用户名:' . $user_name . ')', $this->assign_arr['web_title']);
        $res = $this->admin_cls->add_admin($user_name, $password, $user_type, $user_status);
        if($res==true){
            echo $this->common_cls->json_output('1','教师<label>'.$user_name.'</label>添加成功!');
        }else{
            echo $this->common_cls->json_output('-1','系统繁忙,请重试!');
        }
    }

    /**
     * 修改管理员
     * @param $tid 管理员tid
     */
    public function edit($tid)
    {
        /****权限判断(未完成)*****/
        $tid = intval($tid);
        $user_name = $this->input->post('user_name', true);
        $password = $this->input->post('password_input', true);
        $user_type = $this->input->post('user_type', true);
        $user_status = $this->input->post('user_status', true);
        //检查教师是否不存在
        if ($this->admin_cls->get_counts('tid = ' . $tid) == 0) {
            echo $this->common_cls->json_output('-3','该教师不存在!');
            return;
        }
        if (empty($user_name)) {
            echo $this->common_cls->json_output('-2','输入信息不完整!');
            return;
        }
        //用户名判断(阻止已存在且与自己的用户名不同的)
        $user_info = $this->admin_cls->get_one_admin('tid', array('user_name'=>$user_name));
        if (!empty($user_info) && $user_info['tid'] != $tid) {
            echo $this->common_cls->json_output('-4','该用户名已存在!');
            return;
        }
        /***密码策略(未完成)***/
        $this->log->add_log('修改教师(教师id:' . $tid . ')', $this->assign_arr['web_title']);
        $res = $this->admin_cls->update_admin($tid, $user_name, $password, $user_type, $user_status);
        if($res==true){
            echo $this->common_cls->json_output('1','教师<label>'.$user_name.'</label>修改成功!');
        }else{
            echo $this->common_cls->json_output('-1','系统繁忙,请重试!');
        }
    }

    /**
     * 删除管理员
     * @param $tid 管理员tid
     */
    public function del($tid)
    {
        /****权限判断(未完成)*****/
        $tid = intval($tid);
        if($tid==1){
            echo $this->common_cls->json_output('-1','无法删除系统默认用户!');
            return;
        }
        $this->log->add_log('删除教师(教师id:' . $tid . ')', $this->assign_arr['web_title']);
        $this->admin_cls->del_admin_by_tid($tid);
        echo $this->common_cls->json_output('1','删除教师成功!');
    }

    /**
     * 启用/禁用管理员
     * @param $status 状态(1启用,0禁用)
     */
    public function status_change($status)
    {
        /****权限判断(未完成)*****/
        $tid_str = $this->input->post('tid_str', true);
        $tid_arr = explode(',', $tid_str);
        if (empty($tid_str) || count($tid_arr) == 0) {
            echo $this->common_cls->json_output('-1','请至少勾选一个教师!');
            return;
        }
        foreach ($tid_arr as $k => $v) {
            $tid_arr[$k] = intval($v);
        }
        $status = $status == '1' ? 1 : 0;
        $status_tips = $status == '1' ? '启用' : '禁用';
        $this->log->add_log('修改教师(教师id:' . implode(',', $tid_arr) . ')状态为:' . $status_tips, $this->assign_arr['web_title']);
        $this->admin_cls->change_admin_status($tid_arr, $status);
        echo $this->common_cls->json_output('1',$status_tips.'教师成功!');
    }
}

/* End of file admin_list.php */
/* Location: ./application/controllers/admin/admin_list.php */
