function [MV,NV,MP,NP] = stima_velp_opt(elem_ar,v_al,k,grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad)
n_elem = length(elem_ar);
new_domain = elem_ar;
al_array = v_al(elem_ar);
al_g = (1 - al_array)./(k*al_array);
al_s = heav(al_array);
MAx = reshape(bsxfun(@times,grad_xx(:,:,new_domain),reshape(al_array,1,1,n_elem)),1,36*n_elem);
MAy = reshape(bsxfun(@times,grad_yy(:,:,new_domain),reshape(al_array,1,1,n_elem)),1,36*n_elem);
MAxy = reshape(bsxfun(@times,grad_xy(:,:,new_domain),reshape(al_array,1,1,n_elem)),1,36*n_elem);
MAyx = reshape(bsxfun(@times,grad_yx(:,:,new_domain),reshape(al_array,1,1,n_elem)),1,36*n_elem);
PAx = reshape(pr_x(:,:,new_domain),1,18*n_elem);
PAy = reshape(pr_y(:,:,new_domain),1,18*n_elem);
PAgrad = reshape(bsxfun(@times,pr_grad(:,:,new_domain),reshape(al_g,1,1,n_elem)),1,9*n_elem);
FAx = reshape(bsxfun(@times,source_x(:,new_domain),reshape(al_s,1,n_elem)),1,6*n_elem);
FAy = reshape(bsxfun(@times,source_y(:,new_domain),reshape(al_s,1,n_elem)),1,6*n_elem);

  
 MV = [MAx;MAy;MAxy;MAyx];
 NV = [FAx;FAy];
 MP = [PAx;PAy];
 NP = PAgrad;
end


  
 