/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sn.taskagile.domain.common.model;

import java.io.Serializable;

public abstract class AbstractBaseEntity implements Serializable {

    private static final long serialVersionUID = -1153931912966528994L;

    public abstract boolean equals(Object obj);

    public abstract int hashCode();

    public abstract String toString();

}
