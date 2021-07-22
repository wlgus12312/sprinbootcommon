package com.auc.common.config;

import java.util.Collections;
import java.util.HashMap;

import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.interceptor.NameMatchTransactionAttributeSource;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;

public class TransactionAspManager {
	
	@Autowired
	TransactionManager transactionManager;
	
	@Bean
	public TransactionInterceptor transactionAdvice() {
		NameMatchTransactionAttributeSource txAttributeSource = new NameMatchTransactionAttributeSource();
		RuleBasedTransactionAttribute txAttribute = new RuleBasedTransactionAttribute();
		
		txAttribute.setRollbackRules(Collections.singletonList(new RollbackRuleAttribute(Exception.class)));
		txAttribute.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		HashMap<String, TransactionAttribute> txMethods = new HashMap<String, TransactionAttribute>();
		txMethods.put("*", txAttribute);
		txAttributeSource.setNameMap(txMethods);

		return new TransactionInterceptor(transactionManager, txAttributeSource);
	}

	@Bean
	public Advisor transactionAdviceAdvisor() {
		AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
		pointcut.setExpression("execution(* com..auc..*Impl.*(..))");
		return new DefaultPointcutAdvisor(pointcut, transactionAdvice());
	}

}
