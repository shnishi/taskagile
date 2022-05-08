/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sn.taskagile.domain.common.event;

public interface DomainEventPublisher {

    /**
     * Publish a domain event
     */
    void publish(DomainEvent event);
}
