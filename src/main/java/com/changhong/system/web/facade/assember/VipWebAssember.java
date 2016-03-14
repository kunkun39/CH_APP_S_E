package com.changhong.system.web.facade.assember;

import com.changhong.common.repository.EntityLoadHolder;
import com.changhong.system.domain.VipGroup;
import com.changhong.system.domain.VipMember;
import com.changhong.system.web.facade.dto.VipGroupDTO;
import com.changhong.system.web.facade.dto.VipMemberDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * User: Jack Wang
 * Date: 14-4-9
 * Time: 上午10:58
 */
public class VipWebAssember {

    public static VipGroup toVipGroupDomain(VipGroupDTO vipGroupDTO) {
        VipGroup vipGroup = null;
        if(vipGroupDTO == null) return null;

        if (vipGroupDTO.getId() > 0) {
            vipGroup = (VipGroup) EntityLoadHolder.getUserDao().findById(vipGroupDTO.getId(), VipGroup.class);
            vipGroup.setGroupName(vipGroupDTO.getGroupName());
            vipGroup.setGroupDesc(vipGroupDTO.getGroupDesc());
        } else {
            vipGroup = new VipGroup(vipGroupDTO.getGroupName(), vipGroupDTO.getGroupDesc());
        }

        return vipGroup;
    }

    public static VipGroupDTO toVipGroupDTO(VipGroup vipGroup) {
        final int id = vipGroup.getId();
        final String name = vipGroup.getGroupName();
        final String desc = vipGroup.getGroupDesc();

        VipGroupDTO dto =  new VipGroupDTO(id, name, desc);
        return dto;
    }

    public static List<VipGroupDTO> toVipGroupDTOList(List<VipGroup> vipGroups) {
        List<VipGroupDTO> dtos = new ArrayList<VipGroupDTO>();
        if (vipGroups != null) {
            for (VipGroup vip : vipGroups) {
                dtos.add(toVipGroupDTO(vip));
            }
        }
        return dtos;
    }

    public static VipMember toVipMemberDomain(VipMemberDTO vipMemberDTO) {
        VipMember vipMember = null;
        if(vipMemberDTO == null) return null;

        if (vipMemberDTO.getId() > 0) {
            vipMember = (VipMember) EntityLoadHolder.getUserDao().findById(vipMemberDTO.getId(), VipMember.class);
            vipMember.setBoxMac(vipMemberDTO.getBoxMac());
        } else {
            vipMember = new VipMember(vipMemberDTO.getBoxMac(), vipMemberDTO.getGroupId());
        }

        return vipMember;
    }

    public static VipMemberDTO toVipMemberDTO(VipMember vipMember) {
        final int id = vipMember.getId();
        final String boxMac = vipMember.getBoxMac();
        final int groupId = vipMember.getVipGroup().getId();

        VipMemberDTO dto =  new VipMemberDTO(id, boxMac, groupId);
        return dto;
    }

    public static List<VipMemberDTO> toVipMemberDTOList(List<VipMember> vipMembers) {
        List<VipMemberDTO> dtos = new ArrayList<VipMemberDTO>();
        if (vipMembers != null) {
            for (VipMember member : vipMembers) {
                dtos.add(toVipMemberDTO(member));
            }
        }
        return dtos;
    }
}
